Feature: Show remaining lives
  As a hangman player, I would like to see how many lives are remaining

  Scenario: Remaining lives are shown
    Given I have started a game with 7 lives
    When I view the game
    Then The number of lives I have are displayed
