Feature: Game won
  As a hangman player, I want the game to end when I have guessed the full word

  Scenario: Correctly guessing the last unknown letter wins the game
    Given I am playing a game with the word "xyzzy" and 5 lives remaining
    And I have previously guessed "x"
    And I have previously guessed "y"
    When I guess "z"
    Then I win the game
    And I cannot make another guess

  Scenario: Correctly guessing the word wins the game
    Given I am playing a game with the word "xyzzy" and 5 lives remaining
    And I have previously guessed "z"
    When I guess "xyzzy"
    Then I win the game
    And I cannot make another guess
