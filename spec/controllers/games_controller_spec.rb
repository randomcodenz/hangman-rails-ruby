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
end
