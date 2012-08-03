Feature: SauceLabs.tv home page
  In order to understand WTF saucelabs.tv is
  As a regular user
  The home page should inform me about wtf this thing is

  Scenario: Un-authenticated access to home page
    When I visit the home page
    Then I should be welcomed

