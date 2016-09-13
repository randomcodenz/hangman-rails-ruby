When(/^I guess a letter that is in the word$/) do
  within('form#guess') do
    fill_in('Attempt', :with => 'x')
    click_button
  end
end

Then(/^The guess attempt is shown$/) do
  expect(find('p#guess-attempt')).to have_content("You guessed '#{ Guess.last.attempt }'")
end

Then(/^I am told the letter was in the word$/) do
  expect(find('p#guess-result')).to have_content("Your guess was correct! The word contains 'x'")
end

When(/^I guess a letter that is not in the word$/) do
  within('form#guess') do
    fill_in('Attempt', :with => 'w')
    click_button
  end
end

Then(/^I am told the letter was not in the word$/) do
  expect(find('p#guess-result')).to have_content("Your guess was incorrect! The word does not contain 'w'")
end

When(/^I guess a letter that I have already attempted$/) do
  Game.last.guesses.create( { :attempt => 'y' } )
  within('form#guess') do
    fill_in('Attempt', :with => 'y')
    click_button
  end
end

Then(/^I am told I have already tried that letter$/) do
  expect(find('ul#errors')).to have_content("That guess has already been tried")
end
