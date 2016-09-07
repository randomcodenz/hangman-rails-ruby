Feature: Guess a letter
  As a hangman player, I want to submit one letter guesses and be told whether
  my guess is either in the word, not in the word, or already guessed

  Scenario: Guessing a letter that is in the word
    Given I have started a game
    When I guess a letter that is in the word
    Then The guess attempt is shown
    Then I am told the letter was in the word

  Scenario: Guessing a letter that is not in the word
    Given I have started a game
    When I guess a letter that is not in the word
    Then The guess attempt is shown
    Then I am told the letter was not in the word

  Scenario: Guessing a letter that has already been guessed
    Given I have started a game
    When I guess a letter that I have already attempted
    Then The guess attempt is shown
    Then I am told I have already tried that letter
    Then The guess result is not shown
