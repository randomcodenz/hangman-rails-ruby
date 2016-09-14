Given(/^I am on the homepage$/) do
  visit root_path
end

When(/^I visit the homepage$/) do
  visit root_path
end

When(/^I view the game$/) do
  visit(game_path(Game.last))
end

When(/^I start a new game$/) do
  click_button("New Game")
end
