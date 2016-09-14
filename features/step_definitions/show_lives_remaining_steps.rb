When(/^I view the game$/) do
  visit(game_path(Game.last))
end

Then(/^The number of lives I have are displayed$/) do
  expect(find('span#lives-remaining').text).to eq '7'
end
