Feature: Adding a cyclical usage appliance

  Scenario: Choosing an appliance with a cyclical usage
    When I am on the choose an appliance step
    When I choose an appliance with cyclical usage
    And I proceed to the next step
    Then I am on the how many cycles do you run step

    When I enter 1 cycles
    And I say I use the appliance weekly
    And I proceed to the next step

    When I enter a unit rate
    And I confirm the rate

    Then I am shown a table with my chosen cyclical appliance
    And I am shown a message saying "TEST - Dishwasher (Eco cycle)" added below
