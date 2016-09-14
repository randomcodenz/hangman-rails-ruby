Then(/^The guess result is not shown$/) do
  expect(page).not_to have_css('p#guess-result')
end

Then(/^I cannot make another guess$/) do
  expect(page).not_to have_css('form#guess')
end
