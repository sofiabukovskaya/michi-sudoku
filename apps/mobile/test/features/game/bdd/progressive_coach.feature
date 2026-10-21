Feature: Progressive Sudoku coaching

  Background:
    Given a playable Sudoku game is open

  Scenario: The first hint gives direction without the answer
    When I request the first Coach hint
    Then Coach level Direction is visible
    And no final Coach action is revealed

  Scenario: Another hint narrows the focus
    Given Coach is showing level {0}
    When I request another Coach hint
    Then Coach level Focus is visible
    And no final Coach action is revealed

  Scenario: The reasoning hint keeps the placement hidden
    Given Coach is showing level {1}
    When I request another Coach hint
    Then Coach level Reasoning is visible
    And no final Coach action is revealed

  Scenario: The final hint shows the actual engine deduction
    Given Coach is showing level {2}
    When I request another Coach hint
    Then Coach level Result is visible
    And the actual Coach action is visualized
