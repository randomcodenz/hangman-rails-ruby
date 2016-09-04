require 'rails_helper'

describe Game, type: :model do
  context 'when validating a game' do
    subject { Game.new }

    it { is_expected.to validate_presence_of(:word) }

    it { is_expected.to validate_presence_of(:initial_lives) }

    it { is_expected.to validate_numericality_of(:initial_lives).only_integer.is_greater_than(0) }
  end

  describe '#get_masked_word' do
    let(:word) { 'Powershop' }
    let(:game) { Game.new( { :word => word, :initial_lives => 5 } )}

    subject(:masked_word) { game.get_masked_word }

    context 'when no letters are guessed' do
      it 'returns nil for each letter in the word' do
        expect(masked_word).to eq word.chars.map { nil }
      end
    end
  end
end
