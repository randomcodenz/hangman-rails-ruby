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

    context 'when a letter that appears once is guessed' do
      before { game.guesses.new(:attempt => 'w') }

      it 'returns nil for each letter in the word not guessed' do
        expect(masked_word.values_at(0, 1, 3..8)).to all(be_nil)
      end

      it 'returns the letter if it has been guessed' do
        expect(masked_word[2]).to eq 'w'
      end
    end

    context 'when a letter that appears twice is guessed' do
      before { game.guesses.new(:attempt => 'o') }

      it 'returns nil for each letter in the word not guessed' do
        expect(masked_word.values_at(0, 2..6, 8)).to all(be_nil)
      end

      it 'returns the letter if it has been guessed' do
        expect(masked_word.values_at(1,7)).to all(match 'o')
      end
    end

    context 'is case insensitive' do
      before { game.guesses.new(:attempt => 'p') }

      it 'returns nil for each letter in the word not guessed' do
        expect(masked_word.values_at(1..7)).to all(be_nil)
      end

      it 'returns the letter if it has been guessed' do
        expect(masked_word.values_at(0,8)).to contain_exactly('P', 'p')
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

  describe '#calculate_lives_remaining' do
    let(:initial_lives) { 5 }
    subject(:game) { Game.new(:word => 'xyzzy', :initial_lives => initial_lives) }

    it 'when no guesses have been made lives remaining is the same as initial lives' do
      expect(game.calculate_lives_remaining).to eq initial_lives
    end

    it 'when a correct guesses is made lives remaining is not changed' do
      expect { game.guesses.new(:attempt => 'x') }
        .not_to change { game.calculate_lives_remaining }
    end

    it 'when an incorrect guess is made lives remaining is decremented' do
      expect { game.guesses.new(:attempt => 'w') }
        .to change { game.calculate_lives_remaining }.from(5).to(4)
    end

    it 'when an invalid guess is made lives remaining is unchanged' do
      expect { game.guesses.new(:attempt => '?') }
        .not_to change { game.calculate_lives_remaining }
    end

    it 'when a duplicate guess is made lives remaining is unchanged' do
      expect do
        game.guesses.new(:attempt => 'x')
        game.guesses.new(:attempt => 'x')
      end.not_to change { game.calculate_lives_remaining }
    end
  end

  describe '#incorrect_guesses' do
    subject(:game) { Game.new(:word => 'xyzzy', :initial_lives => 5) }

    it 'when no guesses have been made incorrect guesses is empty' do
      expect(game.incorrect_guesses).to be_empty
    end

    it 'a correct guess is not included' do
      game.guesses.new(:attempt => 'x')
      expect(game.incorrect_guesses).to be_empty
    end

    it 'an incorrect guess is included' do
      game.guesses.new(:attempt => 'w')
      expect(game.incorrect_guesses).to contain_exactly('w')
    end

    it 'an invalid guess is not included' do
      game.guesses.new(:attempt => '?')
      expect(game.incorrect_guesses).to be_empty
    end

    it 'a duplicate correct guess is not included' do
      game.guesses.new(:attempt => 'x')
      # Unique validations suck - only work on saved data so we have to save here
      game.save
      game.guesses.new(:attempt => 'x')
      expect(game.incorrect_guesses).to be_empty
    end

    it 'a duplicate incorrect guess is included once' do
      game.guesses.new(:attempt => 'w')
      # Unique validations suck - only work on saved data so we have to save here
      game.save
      game.guesses.new(:attempt => 'w')
      expect(game.incorrect_guesses).to contain_exactly('w')
    end
  end

  describe '#game_lost?' do
    subject(:game) { Game.new(:word => 'xyzzy', :initial_lives => 1) }

    it 'is false if lives remaining > 0' do
      expect(game.game_lost?).to eq false
    end

    it 'is true if lives remaining is 0' do
      game.guesses.new(:attempt => 'w')
      expect(game.game_lost?).to eq true
    end

  end
end
