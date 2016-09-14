Then(/^"([^"]*)" is shown in the set of incorrect guesses$/) do |guess|
  expect(find('span#incorrect-guesses').text).to eq "#{guess}"
end

Then(/^"([^"]*)" is not shown in the set of incorrect guesses$/) do |guess|
  expect(page).not_to have_css('span#incorrect-guesses')
end

Then(/^"([^"]*)" only appears once in the set of incorrect guesses$/) do |guess|
  expect(find('span#incorrect-guesses').text).to eq "#{guess}"
end
