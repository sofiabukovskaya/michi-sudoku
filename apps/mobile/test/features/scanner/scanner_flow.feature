Feature: Import a photographed Sudoku

  Scenario: Review and correct a recognized clue
    Given a photographed grid has been located and its cells recognized
    When a low-confidence cell is selected and corrected
    Then Review shows the corrected clue and removes its review marker

  Scenario: Reject an invalid recognized board
    Given recognition produced duplicate, impossible, or incomplete clues
    When the player confirms the board
    Then the board remains editable in Review with a specific issue

  Scenario: Continue an imported puzzle in Game
    Given a corrected board has exactly one mathematical solution
    When the player confirms it
    Then the imported clues become immutable givens in Game
    And the Game and Coach session can be restored locally
