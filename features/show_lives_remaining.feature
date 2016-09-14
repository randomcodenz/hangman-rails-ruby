Feature: Show remaining lives
  As a hangman player,
  I would like to see how many lives are remaining

  Scenario: Remaining lives are shown
    Given I have started a game with the word "xyzzy" and 7 lives
    When I view the game
    Then I can see that I have 7 lives remaining
