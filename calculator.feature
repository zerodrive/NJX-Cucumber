Feature: Calculator application

  Scenario: Multiplication

    Given the Calculator application is running
    And I press the 2 key
    And I press the 3 key
    And I press the multiplication key
    And I press the 5 key
    And I press the equals key
    Then the result field should contain 115

  Scenario: Division

    Given the Calculator application is running
    And I press the 2 key
    And I press the 5 key
    And I press the 6 key
    And I press the division key
    And I press the 3 key
    And I press the 2 key
    And I press the equals key
    Then the result field should contain 8
