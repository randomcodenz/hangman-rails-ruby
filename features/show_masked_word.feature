Feature: Show masked word
  As a hangman player,
  I would like to see some indication of how many letters there are in the word
    that I am supposed to guess.
  Each letter should be indicated using an underscore ( _ ) character.

  Scenario: The masked word is displayed on the page
    Given I have started a game with the word "xyzzy"
    Then The masked word should be displayed
