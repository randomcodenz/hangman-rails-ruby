Feature: As a hangman player, I would like to be able to start a new game of hangman

  Allow users to start a new game of hangman.

  Scenario: The new game link should appear on the home page
    Given I am on the homepage
    Then I should see a "New Game" link

  Scenario: Clicking the new game link should start a new game
    Given I am on the homepage
    When I click on the "New Game" link
    Then a new game is started

  Scenario: Creating a new game fails
    Given I am on the homepage
    When I click on the "New Game" link
    And creating a new game fails
    Then I should see a nice error message
