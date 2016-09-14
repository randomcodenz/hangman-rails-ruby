When(/^I view the game$/) do
  visit(game_path(Game.last))
end
