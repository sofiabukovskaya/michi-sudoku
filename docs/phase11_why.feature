Feature: Understand a solved Sudoku cell

  Scenario: Why a Hidden Single belongs in a cell
    Given a player made a correct placement proved by Hidden Single
    When the player opens Why for that digit
    Then the explanation names Hidden Single
    And its numbered facts and board markers come from that deduction
    And no unrelated answer is revealed

  Scenario: Why a Naked Single belongs in a cell
    Given a player made a correct placement proved by Naked Single
    When the player opens Why for that digit
    Then the row, column and box restrictions are shown
    And the final step places only that digit

  Scenario: An original clue
    Given a selected filled cell is an original puzzle clue
    When the player requests Why
    Then the given-digit state is shown
    And no solving technique is fabricated

  Scenario: Restored explanation
    Given an explainable move has been saved
    When the game is restored after restart
    Then the same logical explanation is available
