Feature: Cookie preferences

  Scenario: Visiting a page for the first time
    Given I am on the Energy Comparison Table page
    Then the cookie banner is rendered
