Feature: Show previous guesses
  As a hangman player, I want to see the letters I’ve guessed incorrectly
  so that I don’t guess the same wrong letter again

  Scenario: Incorrect guess is shown
    Given I have started a game with the word "xyzzy"
    When I guess the letter "w"
    Then "w" is shown in the set of incorrect guesses

  Scenario: Correct guess is not shown
    Given I have started a game with the word "xyzzy"
    When I guess the letter "x"
    Then "x" is not shown in the set of incorrect guesses

  Scenario: Invalid guess is not shown
    Given I have started a game with the word "xyzzy"
    When I guess the symbol "@"
    Then "@" is not shown in the set of incorrect guesses

  Scenario: Duplicate correct guess is not shown
    Given I have started a game with the word "xyzzy"
    And I have guessed the letter "x"
    When I guess the letter "x"
    Then "x" is not shown in the set of incorrect guesses

  Scenario: Duplicate incorrect guess is not shown
    Given I have started a game with the word "xyzzy"
    And I have guessed the letter "w"
    When I guess the letter "w"
    Then "w" only appears once in the set of incorrect guesses
