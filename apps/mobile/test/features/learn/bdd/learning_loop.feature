Feature: Learn and practice Sudoku techniques

  Scenario: Learn Hidden Single
    Given the Learn screen is open
    When I select Hidden Single
    Then the Hidden Single lesson is shown
    When I advance through the lesson
    Then I can start Hidden Single practice
    When I solve Hidden Single independently
    Then Learn reflects the saved progress

  Scenario: Solve Naked Single independently
    Given Naked Single practice is open
    When I enter the correct Naked Single placement
    Then independent practice progress is saved

  Scenario: Use Coach during Naked Pair practice
    Given Naked Pair practice is open
    When I ask MICHI and advance through Coach
    Then the result shows candidate eliminations
    And hint assisted practice is not independent
