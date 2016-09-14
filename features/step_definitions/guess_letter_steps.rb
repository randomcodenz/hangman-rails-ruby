Then(/^The guess attempt is shown$/) do
  expect(find('p#guess-attempt')).to have_content("You guessed '#{ Guess.last.attempt }'")
end

Then(/^I am told the letter was in the word$/) do
  expect(find('p#guess-result')).to have_content("Your guess was correct! The word contains 'x'")
end

Then(/^I am told the letter was not in the word$/) do
  expect(find('p#guess-result')).to have_content("Your guess was incorrect! The word does not contain 'w'")
end

Then(/^I am told I have already tried that letter$/) do
  expect(find('ul#errors')).to have_content("That guess has already been tried")
end
