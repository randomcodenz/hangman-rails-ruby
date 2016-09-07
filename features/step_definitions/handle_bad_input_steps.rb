When(/^I guess a number \(([^\)*])\)$/) do |guess|
  within('form#guess') do
    fill_in('Attempt', :with => guess)
    click_button
  end
end

Then(/^I am told "([^"]*)" is not a valid guess attempt$/) do |guess|
  expect(find('ul#errors')).to have_content("That guess is not valid")
end

Then(/^The guess attempt shows the guess \(([^\)*])\)$/) do |guess|
  expect(find('p#guess_attempt')).to have_content("You guessed '#{ guess }'")
end

When(/^I guess a symbol \(([^\)*])\)$/) do |guess|
  within('form#guess') do
    fill_in('Attempt', :with => guess)
    click_button
  end
end
