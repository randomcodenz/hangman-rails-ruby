Given(/^I have started a game with the word "([^"]*)" and (\d+) lives$/) do |word, initial_lives|
  Game.create(:word => word, :initial_lives => initial_lives)
  visit game_path(Game.last)
end

When(/^I make an incorrect guess \("([^"]*)"\)$/) do |guess|
  within('form#guess') do
    fill_in('Attempt', :with => guess)
    click_button
  end
end

Then(/^I should end up with (\d+) lives$/) do |lives_remaining|
  expect(find('span#lives-remaining').text).to eq lives_remaining.to_s
end

When(/^I make an invalid guess \("([^"]*)"\)$/) do |guess|
  within('form#guess') do
    fill_in('Attempt', :with => guess)
    click_button
  end
end

Then(/^I should still have (\d+) lives$/) do |lives_remaining|
  expect(find('span#lives-remaining').text).to eq lives_remaining.to_s
end

When(/^I make a valid guess \("([^"]*)"\)$/) do |guess|
  within('form#guess') do
    fill_in('Attempt', :with => guess)
    click_button
  end
end

When(/^I make a valid guess \("([^"]*)"\) twice$/) do |guess|
  within('form#guess') do
    fill_in('Attempt', :with => guess)
    click_button
  end
  within('form#guess') do
    fill_in('Attempt', :with => guess)
    click_button
  end
end
