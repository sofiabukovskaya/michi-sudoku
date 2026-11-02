Feature: Entering Sudoku digits

  Background:
    Given a playable Sudoku game is open

  Scenario: A correct entry becomes a player digit
    Given an editable empty cell is selected
    When I enter the correct digit
    Then the cell shows a player-entered digit

  Scenario: A wrong entry remains visible as a mistake
    Given an editable empty cell is selected
    When I enter an incorrect digit
    Then the cell shows an error
    And the mistake count increases
