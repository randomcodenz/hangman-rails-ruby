Then(/^I can see the heading "([^"]*)"$/) do |heading|
  expect(page).to have_content(heading)
end

Then(/^I can see the "([^"]*)" button$/) do |button_text|
  expect(page).to have_button(button_text)
end
