require 'rails_helper'

describe Guess, type: :model do
  it { is_expected.to belong_to(:game) }

  context 'when validating a guess' do
    subject { Guess.new(attempt: 'P') }

    it { is_expected.to validate_presence_of(:attempt) }

    it do
      is_expected.to validate_uniqueness_of(:attempt)
        .case_insensitive
        .scoped_to(:game_id)
        .with_message('That guess has already been tried')
    end

    it 'allows single letters' do
      is_expected.to allow_values('A', 'a', 'Z', 'z').for(:attempt)
    end

    it 'does not allow numbers' do
      is_expected.not_to allow_value('0', '1', -1, '-1').for(:attempt)
        .with_message('That guess is not valid')
    end

    it 'does not allow symbols' do
      is_expected.not_to allow_values('!', '#', '%', '$').for(:attempt)
        .with_message('That guess is not valid')
    end

    it 'does not allow multiple characters' do
      is_expected.not_to allow_values('Aa', 'A1', 'A%', 'the').for(:attempt)
        .with_message('That guess is not valid')
    end
  end
end
