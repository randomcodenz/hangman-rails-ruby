require 'rails_helper'

describe GamesController, type: :controller do

  describe "POST #create" do
    it "creates a new game" do
      expect { post :create }.to change(Game, :count).by(1)
    end

    it "redirects to the new game" do
      post :create
      expect(response).to redirect_to(Game.last)
    end
  end

  describe "GET #show" do
    before do
      Game.create( { :word => 'Powershop', :initial_lives => 5 } )
      get :show, id: Game.last
    end

    it { is_expected.to render_template('show') }

    it "passes the requested game to the template" do
      expect(assigns(:game)).to eq Game.last
    end
  end
end
