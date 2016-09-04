Feature: Start new game
  As a hangman player, I would like to be able to start a new game of hangman

  Scenario: The new game button should appear on the home page
    Given I am on the homepage
    Then I should see a "New Game" button

  Scenario: Clicking new game should start a new game
    Given I am on the homepage
    When I start a new game
    Then the new game is displayed

#REVIEW: Bad feature spec - features should not know implementation details
#REVIEW: Rather describe a failure mode - like there are no words in the dictionary
#  Scenario: Creating a new game fails
#    Given I am on the homepage
#    When I click on the "New Game" button
#    And creating a new game fails
#    Then I should see a nice error message
