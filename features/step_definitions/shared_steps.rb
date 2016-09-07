Given(/^I have started a game$/) do
  Game.create( { :word => 'xyzzy', :initial_lives => 5 } )
  visit(game_path(Game.last))
end

Then(/^The guess result is not shown$/) do
  expect(page).not_to have_css('p#guess_result')
end
