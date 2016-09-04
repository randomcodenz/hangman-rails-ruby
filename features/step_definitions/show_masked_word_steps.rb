Given(/^I have started a new game$/) do
  visit root_path
  click_button("New Game")
end

Then(/^The masked word should be displayed$/) do
  expect(page).to have_content('_ _ _ _ _ _ _ _ _')
end
