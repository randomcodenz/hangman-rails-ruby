Then(/^I can see "w" revealed in the masked word$/) do
  expect(find('span#masked-word').text).to eq '_ _ w _ _ _ _ _ _'
end

Then(/^I can see "o" revealed in both locations in the word$/) do
  expect(find('span#masked-word').text).to eq '_ o _ _ _ _ _ o _'
end

Then(/^I can see the masked word$/) do
  expect(find('span#masked-word').text).to eq '_ _ _ _ _'
end
