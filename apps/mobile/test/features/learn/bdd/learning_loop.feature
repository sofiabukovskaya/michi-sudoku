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

  Scenario: Learn X-Wing
    Given the Learn screen is open
    When I select X-Wing
    Then the X-Wing technique screen is shown
    When I open the X-Wing lesson
    Then the X-Wing lesson shows the pattern and practice action

  Scenario: Solve X-Wing eliminations independently
    Given X-Wing practice is open
    When I select exactly the X-Wing eliminations
    Then X-Wing practice is correct and progress is saved

  Scenario: Ask Coach for X-Wing
    Given X-Wing practice is open
    When I advance X-Wing Coach to Result
    Then Result reveals exactly the X-Wing eliminations
