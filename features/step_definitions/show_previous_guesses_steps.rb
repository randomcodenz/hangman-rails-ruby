Given(/^I have started a game with the word "([^"]*)"$/) do |word|
  Game.create(:word => word, :initial_lives => 5)
  visit game_path(Game.last)
end

When(/^I incorrectly guess "([^"]*)"$/) do |guess|
  within('form#guess') do
    fill_in('Attempt', :with => guess)
    click_button
  end
end

Then(/^"([^"]*)" is shown in the set of incorrect guesses$/) do |guess|
  expect(find('span#incorrect_guesses').text).to eq "#{guess}"
end

When(/^I correctly guess "([^"]*)"$/) do |guess|
  within('form#guess') do
    fill_in('Attempt', :with => guess)
    click_button
  end
end

Then(/^"([^"]*)" is not shown in the set of incorrect guesses$/) do |guess|
  expect(page).not_to have_css('span#incorrect_guesses')
end

When(/^I invalidly guess "([^"]*)"$/) do |guess|
  within('form#guess') do
    fill_in('Attempt', :with => guess)
    click_button
  end
end

When(/^I guess "([^"]*)" twice$/) do |guess|
  within('form#guess') do
    fill_in('Attempt', :with => guess)
    click_button
  end
  within('form#guess') do
    fill_in('Attempt', :with => guess)
    click_button
  end
end

Then(/^"([^"]*)" only appears once in the set of incorrect guesses$/) do |guess|
  expect(find('span#incorrect_guesses').text).to eq "#{guess}"
end
