Then(/^"w" is revealed in the masked word$/) do
  expect(find('span#masked-word').text).to eq '_ _ w _ _ _ _ _ _'
end

Then(/^"o" is revealed in both locations in the word$/) do
  expect(find('span#masked-word').text).to eq '_ o _ _ _ _ _ o _'
end
