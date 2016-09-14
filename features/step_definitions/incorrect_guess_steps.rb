Then(/^I can see "([^"]*)" in the incorrect guesses$/) do |guess|
  expect(find('span#incorrect-guesses').text).to eq "#{guess}"
end

Then(/^I cannot see "([^"]*)" in the incorrect guesses$/) do |guess|
  expect(page).not_to have_css('span#incorrect-guesses')
end

Then(/^I can only see "([^"]*)" once in the incorrect guesses$/) do |guess|
  expect(find('span#incorrect-guesses').text).to eq "#{guess}"
end
