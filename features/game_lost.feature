Feature: Game lost
  As a hangman player, I want the game to end when I have run out of lives

  Scenario: Incorrect guess with 1 life ends the game
    Given I am playing a game with the word "xyzzy" and 1 life remaining
    When I guess the letter "w"
    Then I loose the game
    And I cannot make another guess

  Scenario: Correct guess with 1 life does not end the game
    Given I am playing a game with the word "xyzzy" and 1 life remaining
    When I guess the letter "x"
    Then I can continue playing
    And I can make another guess

  Scenario: Invalid guess with 1 life does not end the game
    Given I am playing a game with the word "xyzzy" and 1 life remaining
    When I guess the symbol "!"
    Then I can continue playing
    And I can make another guess

  Scenario: Duplicate correct guess with 1 life does not end the game
    Given I am playing a game with the word "xyzzy" and 1 life remaining
    And I have guessed the letter "x"
    When I guess the letter "x"
    Then I can continue playing
    And I can make another guess

  Scenario: Duplicate incorrect guess with 1 life does not end the game
    Given I am playing a game with the word "xyzzy" and 2 lives remaining
    And I have guessed the letter "w"
    When I guess the letter "w"
    Then I can continue playing
    And I can make another guess
