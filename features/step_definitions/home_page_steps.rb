When(/^I am on the homepage$/) do
  visit "/"
end

Then(/^I should see "([^"]*)"$/) do |heading|
  expect(page).to have_content(heading)
end
