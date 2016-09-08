Given(/^I have started a game with 7 lives$/) do
  Game.create( { :word => 'xyzzy', :initial_lives => 7 } )
end

When(/^I view the game$/) do
  visit(game_path(Game.last))
end

Then(/^The number of lives I have are displayed$/) do
  expect(find('span#lives_remaining').text).to eq '7'
end
