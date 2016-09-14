Then(/^the new game is displayed$/) do
  # TODO What exactly to test given that we have no spec at this time to describe how a game is rendered
  expect(page.current_path).to eq "/games/#{ Game.last.id }"
end

Then(/^I can see that I have (\d+) lives remaining$/) do |lives_remaining|
  expect(find('span#lives-remaining').text).to eq lives_remaining.to_s
end

Then(/^I can continue playing$/) do
  expect(page).not_to have_css('p#game-over')
end

Then(/^I can make another guess$/) do
  expect(page).to have_css('form#guess')
end

Then(/^I loose the game$/) do
  expect(find('p#game-lost').text).to have_content('Game over! Unfortunately you have run out of lives and been hung :(')
end

Then(/^I win the game$/) do
  expect(find('p#game-won').text).to have_content("Game over! You have guessed the word and avoided the hangman's noose :)")
end
