Feature: Clear list

  Scenario: Clearing the list of appliances
    Given I am on the choose an appliance step
    When I add a time based usage for "TEST - Fan heater"
    And I enter a unit rate
    And I confirm the rate
    And I clear the list of appliances

    Then I am returned to the start of the form

    When I add a time based usage for "TEST - Broadband router"

    Then I am asked how much I pay for electricity
    And I enter a unit rate
    And I confirm the rate
    
    Then The list of appliances only has the broadband router and not the fan heater

