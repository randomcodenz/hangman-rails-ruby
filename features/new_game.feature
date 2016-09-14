Feature: Start new game
  As a hangman player, I would like to be able to start a new game of hangman

  Scenario: The new game button should appear on the home page
    Given I am on the homepage
    Then I can see the "New Game" button

  Scenario: Clicking new game should start a new game
    Given I am on the homepage
    When I start a new game
    Then the new game is displayed
