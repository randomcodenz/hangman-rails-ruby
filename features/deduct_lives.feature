Feature: Deduct a live for an incorrect guess
  As a hangman player, there should be 1 life deducted every time I make an
  incorrect guess of a letter that I have not already guessed

  Scenario: Deduct life for incorrect guess
    Given I have started a game with the word "xyzzy" and 5 lives
    When I guess the letter "w"
    Then I can see that I have 4 lives remaining

  Scenario: Do not deduct a life for an invalid guess
    Given I have started a game with the word "xyzzy" and 5 lives
    When I guess the symbol "@"
    Then I can see that I have 5 lives remaining

  Scenario: Do not deduct a life for a correct guess
    Given I have started a game with the word "xyzzy" and 5 lives
    When I guess the letter "x"
    Then I can see that I have 5 lives remaining

  Scenario: Do not deduct a life for a duplicate guess
    Given I have started a game with the word "xyzzy" and 5 lives
    And I have guessed the letter "x"
    When I guess the letter "x"
    Then I can see that I have 5 lives remaining
