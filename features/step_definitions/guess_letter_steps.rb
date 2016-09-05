Given(/^I have started a game$/) do
  Game.create( { :word => 'xyzzy', :initial_lives => 5 } )
  visit(game_path(Game.last))
end

When(/^I guess a letter that is in the word$/) do
  within('form#guess') do
    fill_in('Guess', :with => 'x')
    click_button
  end
end

Then(/^I am told the letter was in the word$/) do
  expect(find('p#guess_result')).to have_content("Correct! The word contains 'x'")
end
