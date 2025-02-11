Feature: Adding a cyclical usage appliance with variants

  Scenario: Choosing an appliance with a cyclical usage with variants
    When I am on the choose an appliance step
    When I choose an appliance with cyclical usage with variants
    And I proceed to the next step
    Then I am asked which variant I use

    When I choose a variant
    And I enter 1 cycles
    And I proceed to the next step

    When I enter a unit rate
    And I confirm the rate

    Then I am shown a table with my chosen cyclical appliance with variants
    And I am shown a message saying "TEST - Tumble Dryer (condenser), Full load, 1 cycles per day" added below
