Feature: Showing the most expensive appliance

  Scenario: Showing the most expensive appliance
    When I am on the choose an appliance step
    When I choose an appliance with time based usage
    And I proceed to the next step
    Then I am on the How much do you use the appliance step

    When I enter 1 hours
    And I say I use the appliance weekly
    And I proceed to the next step
    Then I am asked how much I pay for electricity

    When I enter a unit rate
    And I confirm the rate

    When I add another time based appliance
    Then I am shown which is the most expensive appliance I have added
