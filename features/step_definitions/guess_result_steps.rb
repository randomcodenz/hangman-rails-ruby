Then(/^I am told the letter was in the word$/) do
  expect(find('p#guess-result')).to have_content("Your guess was correct! The word contains 'x'")
end

Then(/^I am told the letter was not in the word$/) do
  expect(find('p#guess-result')).to have_content("Your guess was incorrect! The word does not contain 'w'")
end

Then(/^I cannot see the guess result$/) do
  expect(page).not_to have_css('p#guess-result')
end

Then(/^I cannot make another guess$/) do
  expect(page).not_to have_css('form#guess')
end
