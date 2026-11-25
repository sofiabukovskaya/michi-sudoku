import 'dart:async';
import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:io';
import 'dart:isolate';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_analyzer.dart';
import 'package:michi_mobile/features/puzzle/domain/puzzle_definition.dart';
import 'package:michi_mobile/features/scanner/application/scanner_image_source.dart';
import 'package:michi_mobile/features/scanner/application/scanner_state.dart';
import 'package:michi_mobile/features/scanner/domain/imported_puzzle_repository.dart';
import 'package:sudoku_engine/sudoku_engine.dart';
import 'package:sudoku_scanner/sudoku_scanner.dart';

/// Owns capture intents, Review edits and the user-confirmed import boundary.
final class ScannerCubit extends Cubit<ScannerState> {
  ScannerCubit({
    required this.imageSource,
    required this.scanner,
    required this.analyzer,
    required this.importedPuzzles,
  }) : super(ScannerState.capture(CameraAccess.notRequested));

  final ScannerImageSource imageSource;
  final SudokuScannerService scanner;
  final PuzzleAnalyzer analyzer;
  final ImportedPuzzleRepository importedPuzzles;
  int _generation = 0;

  /// Diagnostics only (`--dart-define=MICHI_SCAN_DEBUG=true`): records what
  /// was recognized next to the kept capture. Compiled out otherwise.
  static const _keepResults = bool.fromEnvironment('MICHI_SCAN_DEBUG');

  Future<void> _keepResult(SudokuScanResult result, ScanFocus? focus) async {
    try {
      final folder = Directory('${Directory.systemTemp.path}/scan_debug');
      await folder.create(recursive: true);
      await File(
        '${folder.path}/result_${DateTime.now().millisecondsSinceEpoch}.json',
      ).writeAsString(
        jsonEncode({
          'focus': focus == null
              ? null
              : [focus.left, focus.top, focus.right, focus.bottom],
          'corners': [
            for (final c in result.geometry.corners) [c.x, c.y],
          ],
          'digits': [for (final c in result.cells) c.prediction.digit ?? 0],
          'confidence': [for (final c in result.cells) c.prediction.confidence],
        }),
      );
    } on FileSystemException {
      // Diagnostics must never affect scanning.
    }
  }

  Future<void> initializeCamera() async {
    final access = await imageSource.openCamera();
    if (!isClosed && state.phase == ScannerPhase.capture) {
      emit(ScannerState.capture(access));
    }
  }

  Future<void> requestCamera() async {
    final access = await imageSource.requestCamera();
    if (!isClosed && state.phase == ScannerPhase.capture) {
      emit(ScannerState.capture(access));
    }
  }

  Future<void> openSettings() => imageSource.openSettings();

  Future<void> resumeCamera() => initializeCamera();

  Future<void> suspendCamera() => imageSource.closeCamera();

  /// [focus] is the on-screen frame in photo fractions: the puzzle inside
  /// it is read even when the page shows others.
  Future<void> capture({ScanFocus? focus}) async {
    if (isClosed || state.phase != ScannerPhase.capture) return;
    try {
      final image = await imageSource.capture();
      if (image != null && !isClosed) {
        await scanImage(image, focus: focus);
      }
    } on ScanFailure catch (failure) {
      if (!isClosed) {
        emit(ScannerState.failure(state.cameraAccess, failure.kind));
      }
    } on Object {
      if (!isClosed) {
        emit(
          ScannerState.failure(
            state.cameraAccess,
            ScanFailureKind.imageDecodeFailure,
          ),
        );
      }
    }
  }

  Future<void> selectPhoto() async {
    if (isClosed) return;
    try {
      final image = await imageSource.selectPhoto();
      if (image != null && !isClosed) {
        await scanImage(image);
      }
    } on ScanFailure catch (failure) {
      if (!isClosed) {
        emit(ScannerState.failure(state.cameraAccess, failure.kind));
      }
    } on Object {
      if (!isClosed) {
        emit(
          ScannerState.failure(
            state.cameraAccess,
            ScanFailureKind.imageDecodeFailure,
          ),
        );
      }
    }
  }

  /// Scans the puzzle the player picked after a multiple-grid photo.
  Future<void> chooseGrid(int index) async {
    final choice = state.gridChoice;
    if (state.phase != ScannerPhase.chooseGrid || choice == null) return;
    RangeError.checkValidIndex(index, choice.grids, 'index');
    await scanImage(choice.image, grid: choice.grids[index]);
  }

  Future<void> scanImage(
    ScanImage image, {
    ScanFocus? focus,
    GridGeometry? grid,
  }) async {
    if (isClosed) return;
    final generation = ++_generation;
    final access = state.cameraAccess;
    emit(ScannerState.processing(access));
    try {
      await imageSource.closeCamera();
      final result = await scanner.scan(image, focus: focus, grid: grid);
      if (_keepResults) unawaited(_keepResult(result, focus));
      if (isClosed || generation != _generation) return;
      final board = SudokuBoard.fromValues([
        for (final cell in result.cells) cell.prediction.digit ?? 0,
      ]);
      emit(ScannerState.review(access, _review(result, board, const {}, null)));
    } on ScanFailure catch (failure) {
      if (isClosed || generation != _generation) return;
      final photo = failure.image;
      if (failure.kind == ScanFailureKind.multipleGrids &&
          photo != null &&
          failure.candidates.length > 1) {
        emit(
          ScannerState.chooseGrid(
            access,
            ScannerGridChoice(image: photo, grids: failure.candidates),
          ),
        );
      } else {
        emit(ScannerState.failure(access, failure.kind));
      }
    } on Object catch (error, stack) {
      developer.log(
        'Scan failed',
        name: 'michi.scanner',
        error: error,
        stackTrace: stack,
      );
      if (!isClosed && generation == _generation) {
        emit(ScannerState.failure(access, ScanFailureKind.recognitionFailure));
      }
    }
  }

  ScannerReviewData _review(
    SudokuScanResult result,
    SudokuBoard board,
    Set<CellRef> edited,
    int? selectedIndex, {
    ScannerReviewIssue? issue,
  }) {
    final conflicts = <CellRef>{
      for (final violation in SudokuConstraints.validate(board).violations)
        ...violation.cells,
    };
    return ScannerReviewData(
      result: result,
      board: board,
      edited: edited,
      conflicts: conflicts,
      selectedIndex: selectedIndex,
      issue: issue,
    );
  }

  void selectCell(int index) {
    final review = state.review;
    if (state.phase != ScannerPhase.review || review == null) return;
    RangeError.checkValueInInterval(index, 0, 80, 'index');
    emit(
      ScannerState.review(
        state.cameraAccess,
        _review(review.result, review.board, review.edited, index),
      ),
    );
  }

  void editSelected(int digit) {
    final review = state.review;
    final index = review?.selectedIndex;
    if (state.phase != ScannerPhase.review || review == null || index == null) {
      return;
    }
    RangeError.checkValueInInterval(digit, 0, 9, 'digit');
    final cell = CellRef.fromIndex(index);
    emit(
      ScannerState.review(
        state.cameraAccess,
        _review(
          review.result,
          review.board.withValue(cell, digit),
          {...review.edited, cell},
          index,
        ),
      ),
    );
  }

  /// Read-only assistance: the reviewed position never enters game storage.
  Future<CoachPlan?> nextHint() async {
    final review = state.review;
    if (state.phase != ScannerPhase.review || review == null) return null;
    final access = state.cameraAccess;
    final generation = ++_generation;
    final board = review.board;
    final solver = analyzer;
    emit(ScannerState.validating(access, review));
    CoachPlan? plan;
    ScannerReviewIssue? issue;
    try {
      if (review.conflicts.isNotEmpty) {
        issue = ScannerReviewIssue.duplicateClues;
      } else if (board.isComplete) {
        issue = ScannerReviewIssue.completed;
      } else {
        (plan, issue) = await Isolate.run(() {
          if (!solver.exactSolver.hasSolution(board)) {
            return (null, ScannerReviewIssue.noSolution);
          }
          final step = solver.humanSolver.findNextDeduction(
            HumanSolverState.initial(board),
          );
          return step == null
              ? (null, ScannerReviewIssue.unsupportedStep)
              : (const StructuredCoachEngine().createPlan(step), null);
        });
      }
    } on Object catch (error, stack) {
      developer.log(
        'Scan hint unavailable',
        name: 'michi.scanner',
        error: error,
        stackTrace: stack,
      );
      issue = ScannerReviewIssue.validation;
    }
    if (isClosed || generation != _generation) return null;
    emit(
      ScannerState.review(
        access,
        _review(
          review.result,
          board,
          review.edited,
          review.selectedIndex,
          issue: issue,
        ),
      ),
    );
    return plan;
  }

  Future<void> confirm() async {
    final review = state.review;
    if (state.phase != ScannerPhase.review || review == null) return;
    final access = state.cameraAccess;
    if (review.conflicts.isNotEmpty) {
      emit(
        ScannerState.review(
          access,
          _review(
            review.result,
            review.board,
            review.edited,
            review.selectedIndex,
            issue: ScannerReviewIssue.duplicateClues,
          ),
        ),
      );
      return;
    }
    final generation = ++_generation;
    emit(ScannerState.validating(access, review));
    PuzzleAnalysis analysis;
    try {
      // Capture only sendable domain values. Capturing this Cubit would also
      // send the platform camera controller and its stream into the isolate.
      final solver = analyzer;
      final board = review.board;
      analysis = await Isolate.run(() => solver.analyze(board));
    } on Object catch (error, stack) {
      developer.log(
        'Import validation failed',
        name: 'michi.scanner',
        error: error,
        stackTrace: stack,
      );
      if (!isClosed && generation == _generation) {
        emit(
          ScannerState.review(
            access,
            _review(
              review.result,
              review.board,
              review.edited,
              review.selectedIndex,
              issue: ScannerReviewIssue.validation,
            ),
          ),
        );
      }
      return;
    }
    if (isClosed || generation != _generation) return;
    if (!analysis.hasSolution || !analysis.hasUniqueSolution) {
      emit(
        ScannerState.review(
          access,
          _review(
            review.result,
            review.board,
            review.edited,
            review.selectedIndex,
            issue: analysis.hasSolution
                ? ScannerReviewIssue.multipleSolutions
                : ScannerReviewIssue.noSolution,
          ),
        ),
      );
      return;
    }
    final supported = analysis.humanResult?.status == HumanSolveStatus.solved;
    final puzzle = PuzzleDefinition.imported(
      board: review.board,
      humanSolverFullySupported: supported,
      requiredTechniques: analysis.requiredTechniques,
      difficulty: supported ? analysis.difficulty : null,
    );
    try {
      await importedPuzzles.save(puzzle);
      if (!isClosed && generation == _generation) {
        emit(ScannerState.imported(access, review, puzzle));
      }
    } on Object catch (error, stack) {
      developer.log(
        'Imported puzzle could not be saved',
        name: 'michi.scanner',
        error: error,
        stackTrace: stack,
      );
      if (!isClosed && generation == _generation) {
        emit(
          ScannerState.review(
            access,
            _review(
              review.result,
              review.board,
              review.edited,
              review.selectedIndex,
              issue: ScannerReviewIssue.storage,
            ),
          ),
        );
      }
    }
  }

  void rescan() {
    _generation++;
    if (!isClosed) {
      emit(ScannerState.capture(state.cameraAccess));
      unawaited(initializeCamera());
    }
  }

  @override
  Future<void> close() async {
    _generation++;
    await imageSource.closeCamera();
    await super.close();
  }
}
