require 'rails_helper'
require 'spec_helper'

describe GamesHelper, type: :helper do
  describe '#masked_word' do
    context 'when no letters are guessed' do
      let(:masked_letters) { [nil, nil, nil] }

      it 'renders the nils as underscores' do
        expect(helper.masked_word(masked_letters)).to eq '_ _ _'
      end
    end

    context 'when some letters are guessed' do
      let(:masked_letters) { [nil, 'h', nil] }

      it 'renders the letters and replaces the nils with underscores' do
        expect(helper.masked_word(masked_letters)).to eq '_ h _'
      end
    end

    context 'when all of the letters are guessed' do
      let(:masked_letters) { ['t', 'h', 'e'] }

      it 'renders the letters' do
        expect(helper.masked_word(masked_letters)).to eq 't h e'
      end
    end
  end

  describe '#guess_attempt' do
    let(:partial) { helper.guess_attempt(guess_attempt) }

    context 'when guess_attempt is nil' do
      let(:guess_attempt) { nil }

      it 'skips rendering the partial' do
        expect(partial.class.name).to eq 'ConditionalPartial::SkipPartial'
      end
    end

    context 'when guess_attempt is not nil' do
      let(:guess_attempt) { 'h' }

      it 'renders the guess_attempt partial' do
        expect(partial.class.name).to eq 'ConditionalPartial::RenderPartial'
        expect(partial.to_partial_path).to eq 'guess_attempt'
      end

      it 'passes the guesses_attempt to the partial' do
        expect(partial.object).to eq guess_attempt
      end
    end
  end

  describe '#guess_result' do
    let(:render_options) { helper.guess_result(guess_correct, guess_attempt) }
    let(:partial) { render_options[:partial] }
    let(:locals) { render_options[:locals] }

    context 'when guess_correct is nil' do
      let(:guess_correct) { nil }
      let(:guess_attempt) { nil }

      it 'skips rendering the partial' do
        expect(partial.class.name).to eq 'ConditionalPartial::SkipPartial'
      end
    end

    context 'when guess_correct is true' do
      let(:guess_correct) { true }
      let(:guess_attempt) { 'z' }

      it 'renders the guess_correct partial' do
        expect(partial.class.name).to eq 'ConditionalPartial::RenderPartial'
        expect(partial.to_partial_path).to eq 'guess_correct'
      end

      it 'passes the guess_attempt to the partial' do
        expect(locals[:guess_attempt]).to eq guess_attempt
      end
    end

    context 'when guess_correct is false' do
      let(:guess_correct) { false }
      let(:guess_attempt) { 'y' }

      it 'renders the guess_incorrect partial' do
        expect(partial.class.name).to eq 'ConditionalPartial::RenderPartial'
        expect(partial.to_partial_path).to eq 'guess_incorrect'
      end

      it 'passes the guess_attempt to the partial' do
        expect(locals[:guess_attempt]).to eq guess_attempt
      end
    end
  end

  describe '#incorrect_guesses' do
    let(:partial) { helper.incorrect_guesses(incorrect_guesses) }

    context 'when incorrect_guesses is empty' do
      let(:incorrect_guesses) { [] }

      it 'skips rendering the partial' do
        expect(partial.class.name).to eq 'ConditionalPartial::SkipPartial'
      end
    end

    context 'when incorrect_guesses is not empty' do
      let(:incorrect_guesses) { ['x'] }

      it 'renders the incorrect_guesses partial' do
        expect(partial.class.name).to eq 'ConditionalPartial::RenderPartial'
        expect(partial.to_partial_path).to eq 'incorrect_guesses'
      end

      it 'passes incorrect_guesses to the partial' do
        expect(partial.object).to eq incorrect_guesses
      end
    end
  end

  describe '#game_over' do
    let(:render_options) { helper.game_over(game) }
    let(:partial) { render_options[:partial] }
    let(:locals) { render_options[:locals] }
    let(:game) do
      instance_double(Game,
        :game_over? => game_over,
        :game_won? => game_won,
        :word => word)
    end

    context 'when game_over? is false' do
      let(:game_over) { false }
      let(:game_won) { false }
      let(:word) { 'word' }

      it 'skips rendering the partial' do
        expect(partial.class.name).to eq 'ConditionalPartial::SkipPartial'
      end
    end

    context 'when game_over? is true' do
      let(:game_over) { true }
      let(:word) { 'word' }

      context 'when game_won? is true' do
        let(:game_won) { true }

        it 'renders the game_won partial' do
          expect(partial.class.name).to eq 'ConditionalPartial::RenderPartial'
          expect(partial.to_partial_path).to eq 'game_won'
        end

        it 'passes the word to the partial' do
          expect(locals[:word]).to eq word
        end
      end

      context 'when game_won? is false' do
        let(:game_won) { false }

        it 'renders the game_lost partial' do
          expect(partial.class.name).to eq 'ConditionalPartial::RenderPartial'
          expect(partial.to_partial_path).to eq 'game_lost'
        end

        it 'passes the word to the partial' do
          expect(locals[:word]).to eq word
        end
      end
    end
  end

  describe '#game_in_progress' do
    let(:game) { instance_double(Game, :game_over? => game_over) }
    let(:render_options) { helper.game_in_progress(game) }
    let(:partial) { render_options[:partial] }
    let(:game_alias) { render_options[:as] }

    context 'when game_over? is true' do
      let(:game_over) { true }

      it 'skips rendering the partial' do
        expect(partial.class.name).to eq 'ConditionalPartial::SkipPartial'
      end
    end

    context 'when game_over? is false' do
      let(:game_over) { false }

      it 'renders the game_in_progress partial' do
        expect(partial.class.name).to eq 'ConditionalPartial::RenderPartial'
        expect(partial.to_partial_path).to eq 'game_in_progress'
      end

      it 'passes the game to the partial' do
        expect(partial.object).to eq game
      end

      it 'passes the game to the partial as "game"' do
        expect(game_alias).to eq :game
      end
    end
  end
end
