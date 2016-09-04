require 'rails_helper'

describe Game, type: :model do
  context 'when validating a game' do
    subject { Game.new }

    it { is_expected.to validate_presence_of(:word) }

    it { is_expected.to validate_presence_of(:initial_lives) }

    it { is_expected.to validate_numericality_of(:initial_lives).only_integer.is_greater_than(0) }
  end
end
