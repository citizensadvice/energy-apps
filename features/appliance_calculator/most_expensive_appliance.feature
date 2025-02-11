Feature: Showing the most expensive appliance

  Scenario: Showing the most expensive appliance
    Given I am on the choose an appliance step
    When I add a time based usage for "TEST - Broadband router"

    And I enter a unit rate
    And I confirm the rate

    And I return to the start of the form
    And I add a time based usage for "TEST - Fan heater"

    Then I am not asked the unit rate again

    Then I am shown which is the most expensive appliance I have added
