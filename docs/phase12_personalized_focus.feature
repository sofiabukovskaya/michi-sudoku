Feature: Personalized learning focus
  MICHI recommends one local, explainable next action from practice and
  technique-specific Coach evidence.

  Scenario: Recent help points to Practice
    Given two recent normal games needed MICHI on Naked Pair
    And Naked Pair is not mastered
    When Home chooses today's learning focus
    Then the existing focus row recommends Naked Pair Practice
    And opening the row opens Naked Pair Practice

  Scenario: The next lesson follows mastery
    Given the earlier supported techniques are mastered
    And Hidden Pair has no practice history
    When a new recommendation is generated
    Then MICHI recommends learning Hidden Pair
    And the current Learn item opens its lesson

  Scenario: The game just finished changes the next step
    Given the completed puzzle needed Naked Triple
    And the player reached a deep Coach hint for Naked Triple
    When the completion screen appears
    Then its single next-step row recommends Naked Triple Practice
    And today's persisted focus is unchanged

  Scenario: Independent practice changes tomorrow's advice
    Given Naked Pair is today's focus
    When independent Practice makes Naked Pair mastered
    Then mastery remains based on Practice
    And today's focus remains stable
    And a fresh local date reads the updated TechniqueProgress
