Given(/^I am playing a game with the word "([^"]*)" and (\d+) (?:life|lives) remaining$/) do |word, initial_lives|
  Game.create(:word => word, :initial_lives => initial_lives)
  visit game_path(Game.last)
end

Given(/^I have previously guessed "([^"]*)"$/) do |guess|
  within('form#guess') do
    fill_in('Attempt', :with => guess)
    click_button
  end
end

Then(/^The game is lost$/) do
  expect(find('p#game_lost').text).to have_content('Game over! Unfortunately you have run out of lives and been hung :(')
end

Then(/^I cannot make another guess$/) do
  expect(page).not_to have_css('form#guess')
end

Then(/^The game does not end$/) do
  expect(page).not_to have_css('p#game_over')
end

Then(/^I can make another guess$/) do
  expect(page).to have_css('form#guess')
end
