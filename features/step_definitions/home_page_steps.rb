When(/^I visit the homepage$/) do
  visit "/"
end

Then(/^I should see "([^"]*)"$/) do |heading|
  expect(page).to have_content(heading)
end
