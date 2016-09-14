Feature: Guess a letter
  As a hangman player,
  I want to submit one letter guesses and be told whether my guess is either
    in the word, not in the word, or already guessed

# REVIEW: Line 9/15/21 Then I should see the guess attempt - keep the subject consistent
  Scenario: Guessing a letter that is in the word
    Given I have started a game with the word "xyzzy"
    When I guess a letter that is in the word
    Then The guess attempt is shown
    Then I am told the letter was in the word

  Scenario: Guessing a letter that is not in the word
    Given I have started a game with the word "xyzzy"
    When I guess a letter that is not in the word
    Then The guess attempt is shown
    Then I am told the letter was not in the word

  Scenario: Guessing a letter that has already been guessed
    Given I have started a game with the word "xyzzy"
    When I guess a letter that I have already attempted
    Then The guess attempt is shown
    Then I am told I have already tried that letter
    Then The guess result is not shown

# REVIEW: Make the cukes more specific - write as if it is going to be used as a test script
