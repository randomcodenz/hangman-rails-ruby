#REVIEW: Extract the repeated within ... into features/support/??_helper
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
