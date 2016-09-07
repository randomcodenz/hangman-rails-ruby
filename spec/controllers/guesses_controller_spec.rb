require 'rails_helper'

describe GuessesController, type: :controller do
  describe 'POST #create' do
    let(:game) { Game.create( { :word => 'xyzzy', :initial_lives => 5 } ) }
    let(:guess_attempt) { 'x' }
    let(:params) do
      {
        :game_id => game.id,
        :guess => { :attempt => guess_attempt }
      }
    end

    it 'redirects to the game' do
      post :create, params
      expect(response).to redirect_to(game)
    end

    it 'passes guess_attempt to show via flash' do
      post :create, params
      expect(flash[:guess_attempt]).to eq guess_attempt
    end

    context 'when the guess has not been attempted' do
      let(:guess_attempt) { 'z' }

      it 'adds a new guess to the game' do
        expect do
          post :create, params
        end.to change(Guess, :count).by(1)
      end

      context 'and the guess is correct' do
        let(:guess_attempt) { 'y' }

        it 'passes a guess outcome of correct to show via flash' do
          post :create, params
          expect(flash[:guess_outcome]).to be :correct
        end
      end

      context 'when the guess is incorrect' do
        let(:guess_attempt) { 'w' }

        it 'passes a guess outcome of incorrect to show via flash' do
          post :create, params
          expect(flash[:guess_outcome]).to be :incorrect
        end
      end
    end

    context 'when the guess has been attempted' do
      let(:guess_attempt) { 'p' }

      before { game.guesses.create( { :attempt => 'p' } ) }

      it 'does not add a new guess to the game' do
        expect do
          post :create, params
        end.not_to change(Guess, :count)
      end

      it 'passes a guess outcome of already tried to show via flash' do
        post :create, params
        expect(flash[:guess_outcome]).to be :already_tried
      end
    end
  end
end
