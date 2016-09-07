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

    #TODO: Test strong params?

    context 'when the guess has not been attempted' do
      let(:guess_attempt) { 'z' }

      it 'adds a new guess to the game' do
        expect do
          post :create, params
        end.to change(Guess, :count).by(1)
      end

      context 'and the guess is correct' do
        let(:guess_attempt) { 'y' }

        before { post :create, params }

        it { should set_flash[:guess_correct].to(true) }

        it { should set_flash[:guess_attempt].to(guess_attempt) }
      end

      context 'when the guess is incorrect' do
        let(:guess_attempt) { 'w' }

        before { post :create, params }

        it { should set_flash[:guess_correct].to(false) }

        it { should set_flash[:guess_attempt].to(guess_attempt) }
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

      it 'passes the error to show via flash' do
        post :create, params
        expect(flash[:error]).to eq( { :attempt => ['That guess has already been tried'] } )
      end

      it 'passes the guess attempt to show via flash' do
        post :create, params
        expect(flash[:guess_attempt]).to eq guess_attempt
      end
    end
  end
end
