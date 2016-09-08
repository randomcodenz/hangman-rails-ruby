Feature: Deduct a live for an incorrect guess
  As a hangman player, there should be 1 life deducted every time I make an
  incorrect guess of a letter that I have not already guessed

  Scenario: Deduct life for incorrect guess
    Given I have started a game with the word "xyzzy" and 5 lives
    When I make an incorrect guess ("w")
    Then I should end up with 4 lives

  Scenario: Do not deduct a life for an invalid guess
    Given I have started a game with the word "xyzzy" and 5 lives
    When I make an invalid guess ("@")
    Then I should still have 5 lives

  Scenario: Do not deduct a life for a correct guess
    Given I have started a game with the word "xyzzy" and 5 lives
    When I make a valid guess ("x")
    Then I should still have 5 lives

  Scenario: Do not deduct a life for a duplicate guess
    Given I have started a game with the word "xyzzy" and 5 lives
    When I make a valid guess ("x") twice
    Then I should still have 5 lives
