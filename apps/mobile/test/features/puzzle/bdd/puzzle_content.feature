Feature: Local puzzle content and Daily Sudoku

  Scenario: Start a Medium puzzle from the catalog
    Given Home has no active game
    When I choose Medium and start a puzzle
    Then a catalog Medium game is active

  Scenario: Start today's Daily Sudoku
    Given Home has today's unfinished Daily
    When I start Sudoku of the Day
    Then today's Daily session is active

  Scenario: Complete today's Daily Sudoku
    Given today's Daily is one move from completion
    When I finish today's Daily
    Then Home marks today's Daily completed
