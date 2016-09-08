Given(/^I have started a game with the word "Powershop"$/) do
  Game.create( { :word => 'Powershop', :initial_lives => 5 } )
  visit(game_path(Game.last))
end

When(/^I guess "([^"]+)"$/) do |guess|
  within('form#guess') do
    fill_in('Attempt', :with => guess)
    click_button
  end
end

Then(/^"w" is revealed in the masked word$/) do
  expect(find('span#masked_word').text).to eq '_ _ w _ _ _ _ _ _'
end

Then(/^"o" is revealed in both locations in the word$/) do
  expect(find('span#masked_word').text).to eq '_ o _ _ _ _ _ o _'
end
