Then(/^I can see the guess attempt$/) do
  expect(find('p#guess-attempt')).to have_content("You guessed '#{ Guess.last.attempt }'")
end

Then(/^I am told I have already tried that letter$/) do
  expect(find('ul#errors')).to have_content("That guess has already been tried")
end

Then(/^I am told "([^"]*)" is not a valid guess attempt$/) do |guess|
  expect(find('ul#errors')).to have_content("That guess is not valid")
end
