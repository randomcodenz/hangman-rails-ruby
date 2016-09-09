Given(/^I have started a game$/) do
  Game.create( { :word => 'xyzzy', :initial_lives => 5 } )
  visit(game_path(Game.last))
end

Given(/^I have started a game with the word "([^"]*)"$/) do |word|
  Game.create(:word => word, :initial_lives => 5)
  visit game_path(Game.last)
end

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

When(/^I guess "([^"]+)"$/) do |guess|
  within('form#guess') do
    fill_in('Attempt', :with => guess)
    click_button
  end
end

Then(/^The guess result is not shown$/) do
  expect(page).not_to have_css('p#guess_result')
end

Then(/^I cannot make another guess$/) do
  expect(page).not_to have_css('form#guess')
end
