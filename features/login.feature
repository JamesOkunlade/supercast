# features/login.feature

Feature: Login
  As a user
  I want to log in
  So that I can access Supercast and see the podcasts

  Scenario: User logs in successfully
    Given I am on the login page
    When I fill in the login form
    And I click the submit button
    Then I should see podcast page
