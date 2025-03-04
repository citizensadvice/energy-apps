Feature: Enforcing the maximum number of appliances in the list (10)

  Scenario: Adding the maximum number of appliances
    Given I am on the choose an appliance step
    When I add a time based usage for "TEST - Broadband router"

    And I enter a unit rate
    And I confirm the rate

    And I return to the start of the form
    And I add a time based usage for "TEST - Fan heater"
    And I return to the start of the form
    And I add a time based usage for "TEST - Fan heater"
    And I return to the start of the form
    And I add a time based usage for "TEST - Fan heater"
    And I return to the start of the form
    And I add a time based usage for "TEST - Fan heater"
    And I return to the start of the form
    And I add a time based usage for "TEST - Fan heater"
    And I return to the start of the form
    And I add a time based usage for "TEST - Fan heater"
    And I return to the start of the form
    And I add a time based usage for "TEST - Fan heater"
    And I return to the start of the form
    And I add a time based usage for "TEST - Fan heater"
    And I return to the start of the form
    And I add a time based usage for "TEST - Fan heater"

    Then I cannot return to the start of the form
    And I am told I have added the maximum number of appliances
