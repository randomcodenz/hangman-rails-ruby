Feature: Game lost
  As a hangman player, I want the game to end when I have run out of lives

  Scenario: Incorrect guess with 1 life ends the game
    Given I am playing a game with the word "xyzzy" and 1 life remaining
    When I guess "w"
    Then The game is lost
    And I cannot make another guess

  Scenario: Correct guess with 1 life does not end the game
    Given I am playing a game with the word "xyzzy" and 1 life remaining
    When I guess "x"
    Then The game does not end
    And I can make another guess

  Scenario: Invalid guess with 1 life does not end the game
    Given I am playing a game with the word "xyzzy" and 1 life remaining
    When I guess "!"
    Then The game does not end
    And I can make another guess

  Scenario: Duplicate correct guess with 1 life does not end the game
    Given I am playing a game with the word "xyzzy" and 1 life remaining
    And I have previously guessed "x"
    When I guess "x"
    Then The game does not end
    And I can make another guess

  Scenario: Duplicate incorrect guess with 1 life does not end the game
    Given I am playing a game with the word "xyzzy" and 2 lives remaining
    And I have previously guessed "w"
    When I guess "w"
    Then The game does not end
    And I can make another guess
