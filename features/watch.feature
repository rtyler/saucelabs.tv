Feature: Watch recorded job runs
  As a browser
  I want to watch videos from past job runs
  So that I can have an idea of how tests are running even if I'm not 100%
  focused on the videos and test results


  Scenario: Unauthenticated user
    Given I am an unauthenticated user
    When I try to watch videos
    Then I should be prompted to log in with my username and API key

  Scenario: Authenticated user
    Given I have a valid Sauce Labs username and API key
    And I have recent jobs
    When I try to watch videos
    And I enter my credentials
    Then I should be given a list of jobs


