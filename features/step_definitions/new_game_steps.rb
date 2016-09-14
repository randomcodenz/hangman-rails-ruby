Given(/^I am on the homepage$/) do
  visit root_path
end

Then(/^I should see a "([^"]*)" button$/) do |button_text|
  expect(page).to have_button(button_text)
end

When(/^I start a new game$/) do
  click_button("New Game")
end
