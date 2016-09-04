Given(/^I am on the homepage$/) do
  visit root_path
end

Then(/^I should see a "([^"]*)" button$/) do |button_text|
  expect(page).to have_button(button_text)
end

When(/^I start a new game$/) do
  click_button("New Game")
end

Then(/^the new game is displayed$/) do
  # TODO What exactly to test given that we have no spec at this time to describe how a game is rendered
  expect(page.current_path).to eq "/games/#{ Game.last.id }"
end
