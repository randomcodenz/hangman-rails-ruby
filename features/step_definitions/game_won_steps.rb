Then(/^I win the game$/) do
  expect(find('p#game-won').text).to have_content("Game over! You have guessed the word and avoided the hangman's noose :)")
end
