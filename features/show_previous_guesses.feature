Feature: Show previous guesses
  As a hangman player, I want to see the letters I’ve guessed incorrectly
  so that I don’t guess the same wrong letter again

  Scenario: Incorrect guess is shown
    Given I have started a game with the word "xyzzy"
    When I guess the letter "w"
    Then I can see "w" in the incorrect guesses

  Scenario: Correct guess is not shown
    Given I have started a game with the word "xyzzy"
    When I guess the letter "x"
    Then I cannot see "x" in the incorrect guesses

  Scenario: Invalid guess is not shown
    Given I have started a game with the word "xyzzy"
    When I guess the symbol "@"
    Then I cannot see "@" in the incorrect guesses

  Scenario: Duplicate correct guess is not shown
    Given I have started a game with the word "xyzzy"
    And I have guessed the letter "x"
    When I guess the letter "x"
    Then I cannot see "x" in the incorrect guesses

  Scenario: Duplicate incorrect guess is not shown
    Given I have started a game with the word "xyzzy"
    And I have guessed the letter "w"
    When I guess the letter "w"
    Then I can only see "w" once in the incorrect guesses
