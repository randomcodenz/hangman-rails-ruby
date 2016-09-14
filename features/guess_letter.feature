Feature: Guess a letter
  As a hangman player,
  I want to submit one letter guesses and be told whether my guess is either
    in the word, not in the word, or already guessed

  Scenario: Guessing a letter that is in the word
    Given I have started a game with the word "xyzzy"
    When I guess the letter "x"
    Then I can see the guess attempt
    Then I am told the letter was in the word

  Scenario: Guessing a letter that is not in the word
    Given I have started a game with the word "xyzzy"
    When I guess the letter "w"
    Then I can see the guess attempt
    Then I am told the letter was not in the word

  Scenario: Guessing a letter that has already been guessed
    Given I have started a game with the word "xyzzy"
    And I have guessed the letter "x"
    When I guess the letter "x"
    Then I can see the guess attempt
    Then I am told I have already tried that letter
    Then I cannot see the guess result
