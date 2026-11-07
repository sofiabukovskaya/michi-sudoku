import 'dart:async';
import 'dart:developer' as developer;
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

  Future<void> capture() async {
    if (isClosed || state.phase != ScannerPhase.capture) return;
    try {
      final image = await imageSource.capture();
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

  Future<void> scanImage(ScanImage image) async {
    if (isClosed) return;
    final generation = ++_generation;
    final access = state.cameraAccess;
    emit(ScannerState.processing(access));
    try {
      await imageSource.closeCamera();
      final result = await scanner.scan(image);
      if (isClosed || generation != _generation) return;
      final board = SudokuBoard.fromValues([
        for (final cell in result.cells) cell.prediction.digit ?? 0,
      ]);
      emit(ScannerState.review(access, _review(result, board, const {}, null)));
    } on ScanFailure catch (failure) {
      if (!isClosed && generation == _generation) {
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
