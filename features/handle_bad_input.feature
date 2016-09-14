Feature: Handle bad input
  As a hangman player,
  I want the game to handle bad input (like numbers, symbols, and letters I
    have previously guessed) gracefully and with an appropriate error message
  So that I am not punished unduly for mistakes

  Previously guessed letters are already handled as outlined in
  guess_letter.feature / guessing a letter that has already been guessed

  Scenario: Guessing a number
    Given I have started a game with the word "xyzzy"
    When I guess the number "3"
    Then I am told "3" is not a valid guess attempt
    Then I cannot see the guess result

  Scenario: Guessing a symbol
    Given I have started a game with the word "xyzzy"
    When I guess the symbol "$"
    Then I am told "$" is not a valid guess attempt
    Then I cannot see the guess result
