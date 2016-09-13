require 'rails_helper'

describe Game, type: :model do
  def create_game(word, lives)
    Game.create!(:word => word, :initial_lives => lives)
  end

  def make_guess(game, attempt)
    game.guesses.create(:attempt => attempt)
  end

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
    let(:game) { create_game(word, 5) }

    subject(:masked_word) { game.get_masked_word }

    context 'when no letters are guessed' do
      it 'returns nil for each letter in the word' do
        expect(masked_word).to eq word.chars.map { nil }
      end
    end

    context 'when a letter that appears once is guessed' do
      before { make_guess(game, 'w') }

      it 'returns nil for each letter in the word not guessed' do
        expect(masked_word.values_at(0, 1, 3..8)).to all(be_nil)
      end

      it 'returns the letter if it has been guessed' do
        expect(masked_word[2]).to eq 'w'
      end
    end

    context 'when a letter that appears twice is guessed' do
      before { make_guess(game, 'o') }

      it 'returns nil for each letter in the word not guessed' do
        expect(masked_word.values_at(0, 2..6, 8)).to all(be_nil)
      end

      it 'returns the letter if it has been guessed' do
        expect(masked_word.values_at(1,7)).to all(match 'o')
      end
    end

    context 'is case insensitive' do
      before { make_guess(game, 'p') }

      it 'returns nil for each letter in the word not guessed' do
        expect(masked_word.values_at(1..7)).to all(be_nil)
      end

      it 'returns the letter if it has been guessed' do
        expect(masked_word.values_at(0,8)).to contain_exactly('P', 'p')
      end
    end
  end

  describe '#is_correct_guess?' do
    let(:guess) { make_guess(game, guess_attempt ) }

    subject(:game) { create_game('xyzzy', 5) }

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
    subject(:game) { create_game('xyzzy', initial_lives) }

    it 'when no guesses have been made lives remaining is the same as initial lives' do
      expect(game.calculate_lives_remaining).to eq initial_lives
    end

    it 'when a correct guesses is made lives remaining is not changed' do
      expect { make_guess(game, 'x') }
        .not_to change { game.calculate_lives_remaining }
    end

    it 'when an incorrect guess is made lives remaining is decremented' do
      expect { make_guess(game, 'w') }
        .to change { game.calculate_lives_remaining }.from(5).to(4)
    end

    it 'when an invalid guess is made lives remaining is unchanged' do
      expect { make_guess(game, '?') }
        .not_to change { game.calculate_lives_remaining }
    end

    it 'when a duplicate guess is made lives remaining is unchanged' do
      expect do
        make_guess(game, 'x')
        make_guess(game, 'x')
      end.not_to change { game.calculate_lives_remaining }
    end
  end

  describe '#incorrect_guesses' do
    subject(:game) { create_game('xyzzy', 5) }

    it 'when no guesses have been made incorrect guesses is empty' do
      expect(game.incorrect_guesses).to be_empty
    end

    it 'a correct guess is not included' do
      make_guess(game, 'x')
      expect(game.incorrect_guesses).to be_empty
    end

    it 'an incorrect guess is included' do
      make_guess(game, 'w')
      expect(game.incorrect_guesses).to contain_exactly('w')
    end

    it 'an invalid guess is not included' do
      make_guess(game, '?')
      expect(game.incorrect_guesses).to be_empty
    end

    it 'a duplicate correct guess is not included' do
      make_guess(game, 'x')
      # Unique validations suck - only work on saved data so we have to save here
      game.save
      make_guess(game, 'x')
      expect(game.incorrect_guesses).to be_empty
    end

    it 'a duplicate incorrect guess is included once' do
      make_guess(game, 'w')
      # Unique validations suck - only work on saved data so we have to save here
      game.save
      make_guess(game, 'w')
      expect(game.incorrect_guesses).to contain_exactly('w')
    end
  end

  describe '#game_lost?' do
    subject(:game) { create_game('xyzzy', 1) }

    it 'is false if lives remaining > 0' do
      expect(game.game_lost?).to be false
    end

    it 'is true if lives remaining is 0' do
      make_guess(game, 'w')
      expect(game.game_lost?).to be true
    end
  end

  describe '#game_won?' do
    subject(:game) { create_game('xyzzy', 1) }

    it 'is false if none of the letter are guessed' do
      expect(game.game_won?).to be false
    end

    it 'is false if some of the letter are not guessed' do
      make_guess(game, 'z')
      expect(game.game_won?).to be false
    end

    it 'is true if all letters are guessed and lives remaining > 0' do
      make_guess(game, 'x')
      make_guess(game, 'y')
      make_guess(game, 'z')
      expect(game.game_won?).to be true
    end

    it 'is false if all letters are guessed and lives remaining is 0' do
      make_guess(game, 'w')
      make_guess(game, 'x')
      make_guess(game, 'y')
      make_guess(game, 'z')
      expect(game.game_won?).to be false
    end
  end

  describe '#game_over?' do
    subject(:game) { create_game('xyzzy', 1) }

    it 'is true if game_lost? is true' do
      make_guess(game, 'w')
      # TODO: Assert that game_lost? is true?
      expect(game.game_over?).to be true
    end

    it 'is true if game_won? is true' do
      make_guess(game, 'x')
      make_guess(game, 'y')
      make_guess(game, 'z')
      # TODO: Assert that game_won? is true?
      expect(game.game_over?).to be true
    end

    it 'is false if game_lost? and game_won? are false' do
      # TODO: Assert that game_won? and game_lost? are false?
      expect(game.game_over?).to be false
    end
  end
end
