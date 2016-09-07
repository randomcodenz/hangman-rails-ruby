require 'rails_helper'

describe Game, type: :model do
  it { is_expected.to have_many(:guesses) }

  context 'when validating a game' do
    it { is_expected.to validate_presence_of(:word) }

    it { is_expected.to validate_presence_of(:initial_lives) }

    it { is_expected.to validate_numericality_of(:initial_lives).only_integer.is_greater_than(0) }

    it 'is expected to validate all associated guesses'
    #TODO: There are no shoulda matchers for doing this
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

  describe '#is_correct_guess?' do
    let(:guess) { game.guesses.new( { :attempt => guess_attempt } ) }

    subject(:game) { Game.new( { :word => 'xyzzy', :initial_lives => 5 } ) }

    context 'when the guess is in the word' do
      let(:guess_attempt) { 'x' }

      it 'returns true' do
        expect(game.is_correct_guess?(guess)).to be true
      end
    end

    context 'when the guess is not in the word' do
      let(:guess_attempt) { 'w' }

      it 'returns false' do
        expect(game.is_correct_guess?(guess)).to be false
      end
    end
  end
end
