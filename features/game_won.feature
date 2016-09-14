Feature: Game won
  As a hangman player, I want the game to end when I have guessed the full word

  Scenario: Correctly guessing the last unknown letter wins the game
    Given I am playing a game with the word "xyzzy" and 5 lives remaining
    And I have guessed the letter "x"
    And I have guessed the letter "y"
    When I guess the letter "z"
    Then I win the game
    And I cannot make another guess

  Scenario: Correctly guessing the word wins the game
    Given I am playing a game with the word "xyzzy" and 5 lives remaining
    And I have guessed the letter "z"
    When I guess the word "xyzzy"
    Then I win the game
    And I cannot make another guess
