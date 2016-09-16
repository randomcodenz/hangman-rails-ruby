require 'rails_helper'
require 'spec_helper'

describe GamesHelper, type: :helper do
  describe '#render_masked_word' do
    context 'when no letters are guessed' do
      let(:masked_letters) { [nil, nil, nil] }

      it 'renders the nils as underscores' do
        expect(helper.render_masked_word(masked_letters)).to eq '_ _ _'
      end
    end

    context 'when some letters are guessed' do
      let(:masked_letters) { [nil, 'h', nil] }

      it 'renders the letters and replaces the nils with underscores' do
        expect(helper.render_masked_word(masked_letters)).to eq '_ h _'
      end
    end

    context 'when all of the letters are guessed' do
      let(:masked_letters) { ['t', 'h', 'e'] }

      it 'renders the letters' do
        expect(helper.render_masked_word(masked_letters)).to eq 't h e'
      end
    end
  end

  describe '#guess_attempt' do
    it 'returns MaybeTemplate::None if guess_attempt is nil' do
      expect(helper.guess_attempt(nil)).to be_nil
    end

    context 'when guess_attempt is not nil' do
      before {  }

      it 'renders the guess_attempt partial' do
        skip "Developer broken attempting to rspec"
        expect(helper.render_guess_attempt('h')).to have_rendered('guess_attempt')
      end
    end
  end

  describe '#render_guess_result' do
    it 'returns nil if guess_correct is nil'
    it 'renders the guess_correct partial if guess_correct is true'
    it 'renders the guess_incorrect partial if guess_correct is false'
  end

  describe '#render_incorrect_guesses' do
    it 'returns nil if incorrect_guesses is empty'
    it 'renders the incorrect_guesses partial if incorrect_guesses is not empty'
  end

  describe '#render_game_over' do
    it 'returns nil if game_over? is false'
    it 'renders the game_won partial if game_won? is true'
    it 'renders the game_lost partial if game_lost? is true'
  end

  describe '#render_game_in_progress' do
    it 'returns nil if game_over? is true'
    it 'renders the game_in_progress partial if game_over? is false'
  end
end
