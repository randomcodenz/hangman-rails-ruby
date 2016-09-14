Given(/^I have started a game with the word "([^"]*)"$/) do |word|
  Game.create(:word => word, :initial_lives => 5)
  visit game_path(Game.last)
end

Given(/^I (?:have started|am playing) a game with the word "([^"]*)" and (\d+) (?:life|lives)(?:| remaining)$/) do |word, initial_lives|
  Game.create(:word => word, :initial_lives => initial_lives)
  visit game_path(Game.last)
end
