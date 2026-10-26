Feature: Local Sudoku game lifecycle

  Scenario: Continue an unfinished game after reopening
    Given an unfinished local game with entries and notes
    When the game is reopened from local storage
    Then the board notes mistakes timer and undo are restored

  Scenario: Pause and resume a running game
    Given a running Sudoku is shown
    When I pause the Sudoku
    Then the board is hidden and input is disabled and time stops
    When I resume the Sudoku
    Then the board returns and time continues

  Scenario: Finish a locally saved game
    Given a locally saved Sudoku one move from completion
    When I enter the final correct number
    Then the game is completed once and the active game is removed
    And Home no longer offers Continue
