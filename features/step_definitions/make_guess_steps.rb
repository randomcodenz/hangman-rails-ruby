Given(/^I have guessed the letter "([^"]+)"$/) do |guess|
  within('form#guess') do
    fill_in('Attempt', :with => guess)
    click_button
  end
end

When(/^I guess the (?:letter|number|symbol|word) "([^"]+)"$/) do |guess|
  within('form#guess') do
    fill_in('Attempt', :with => guess)
    click_button
  end
end
