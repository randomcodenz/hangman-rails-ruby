Then(/^The game is lost$/) do
  expect(find('p#game-lost').text).to have_content('Game over! Unfortunately you have run out of lives and been hung :(')
end

Then(/^The game does not end$/) do
  expect(page).not_to have_css('p#game-over')
end

Then(/^I can make another guess$/) do
  expect(page).to have_css('form#guess')
end
