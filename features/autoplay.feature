Feature: Auto-play videos
  As an authenticated Sauce Labs user
  I should be able to auto-play past videos
  So that I can waste electricity and have a fancy office dashboard of Selenium tests

  Background: Ensure we're always logged in
    Given I have a valid Sauce Labs username and API key

  @wip
  Scenario: Auto-play the most recent 10 videos
    Given I have recent jobs
    And I am logged in
    When I start the auto-player
    Then the oldest job should start playing
