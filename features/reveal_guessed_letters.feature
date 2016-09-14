Feature: Reveal guessed letters
  As a hangman player, I want to see the letters I’ve guessed correctly revealed
  on the hidden word that I am trying to guess so that I can guess the word
  more readily

  Scenario: Guessing a letter that appears in the word once
    Given I have started a game with the word "Powershop"
    When I guess the letter "w"
    Then "w" is revealed in the masked word

  Scenario: Guessing a letter that appears in the word twice
    Given I have started a game with the word "Powershop"
    When I guess the letter "o"
    Then "o" is revealed in both locations in the word
