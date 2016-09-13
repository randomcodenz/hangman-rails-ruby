Given(/^I have started a new game$/) do
  Game.create( { :word => 'xyzzy', :initial_lives => 5 } )
  visit(game_path(Game.last))
end

Then(/^The masked word should be displayed$/) do
  expect(find('span#masked-word').text).to eq '_ _ _ _ _'
end
