Then(/^I am told "([^"]*)" is not a valid guess attempt$/) do |guess|
  expect(find('ul#errors')).to have_content("That guess is not valid")
end

Then(/^The guess attempt shows the guess \(([^\)*])\)$/) do |guess|
  expect(find('p#guess_attempt')).to have_content("You guessed '#{ guess }'")
end
