/// Stable semantic identifiers. Presentation owns localized names and text.
enum SudokuTechnique {
  nakedSingle,
  hiddenSingle,
  nakedPair,
  hiddenPair,
  pointingPair,
  boxLineReduction,
  nakedTriple,
  xWing,
  xyWing,
}

/// Educational and solving priority. Persist the enum name, never its rank.
abstract final class SudokuTechniqueOrder {
  static const supported = <SudokuTechnique>[
    SudokuTechnique.nakedSingle,
    SudokuTechnique.hiddenSingle,
    SudokuTechnique.nakedPair,
    SudokuTechnique.pointingPair,
    SudokuTechnique.hiddenPair,
    SudokuTechnique.boxLineReduction,
    SudokuTechnique.nakedTriple,
    SudokuTechnique.xWing,
  ];

  static int rank(SudokuTechnique technique) => supported.indexOf(technique);
}
