Feature: Adding a time based usage appliance

  Scenario: Choosing an appliance with time based usage
    When I am on the choose an appliance step
    When I choose an appliance with time based usage
    And I say I have two of them
    And I proceed to the next step
    Then I am on the How much do you use the appliance step

    When I enter 1 hours
    And I enter 30 minutes
    And I say I use the appliance weekly
    And I proceed to the next step
    Then I am asked how much I pay for electricity

    When I enter a unit rate
    And I confirm the rate
    Then I am shown a table with my chosen appliance
    And I am shown a message showing my most recently added appliance
