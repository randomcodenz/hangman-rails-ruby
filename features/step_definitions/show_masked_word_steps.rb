Then(/^The masked word should be displayed$/) do
  expect(find('span#masked-word').text).to eq '_ _ _ _ _'
end
