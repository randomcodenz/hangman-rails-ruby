Feature: As a hangman player, I would like to be able to visit the homepage

  Simple feature to ensure the application is running and responding as expected
  and all of the cucumber / rspec / other bits are operating in harmony ;)

  Scenario: View the hangman home page
      When I visit the homepage
      Then I should see "Welcome to Hangman!"
