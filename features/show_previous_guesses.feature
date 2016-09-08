Feature: Show previous guesses
  As a hangman player, I want to see the letters I’ve guessed incorrectly
  so that I don’t guess the same wrong letter again

  Scenario: Incorrect guess is shown
    Given I have started a game with the word "xyzzy"
    When I incorrectly guess "w"
    Then "w" is shown in the set of incorrect guesses

  Scenario: Correct guess is not shown
    Given I have started a game with the word "xyzzy"
    When I correctly guess "x"
    Then "x" is not shown in the set of incorrect guesses

  Scenario: Invalid guess is not shown
    Given I have started a game with the word "xyzzy"
    When I invalidly guess "@"
    Then "@" is not shown in the set of incorrect guesses

  Scenario: Duplicate correct guess is not shown
    Given I have started a game with the word "xyzzy"
    When I guess "x" twice
    Then "x" is not shown in the set of incorrect guesses

  Scenario: Duplicate incorrect guess is not shown
    Given I have started a game with the word "xyzzy"
    When I guess "w" twice
    Then "w" only appears once in the set of incorrect guesses
