require 'rails_helper'

describe Guess, type: :model do
  it { is_expected.to belong_to(:game) }

  context 'when validating a guess' do
    it { is_expected.to validate_presence_of(:attempt) }
  end
end
