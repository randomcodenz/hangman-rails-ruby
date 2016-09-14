Then(/^I should end up with (\d+) lives$/) do |lives_remaining|
  expect(find('span#lives-remaining').text).to eq lives_remaining.to_s
end

Then(/^I should still have (\d+) lives$/) do |lives_remaining|
  expect(find('span#lives-remaining').text).to eq lives_remaining.to_s
end
