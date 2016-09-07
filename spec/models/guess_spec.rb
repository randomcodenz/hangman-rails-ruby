require 'rails_helper'

describe Guess, type: :model do
  it { is_expected.to belong_to(:game) }

  context 'when validating a guess' do
    subject { Guess.new(attempt: 'P') }

    it { is_expected.to validate_presence_of(:attempt) }

    it do
      is_expected.to validate_uniqueness_of(:attempt)
        .case_insensitive
        .with_message('That guess has already been tried')
    end
  end
end
