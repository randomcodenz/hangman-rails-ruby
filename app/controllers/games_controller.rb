class GamesController < ApplicationController
  DEFAULT_LIVES = 5
  DEFAULT_WORD = 'Powershop'

  # index, show, new, create, edit, update, destroy

  def show
    @game = Game.includes(:guesses).find(params[:id])
  end

  def create
    @game = Game.create!(:word => DEFAULT_WORD, :initial_lives => DEFAULT_LIVES)
    redirect_to @game
  end

  private

  # def get_word(difficulty)
  #   case difficulty
  #   when "medium"
  #   when "hard"
  #   when "expert"
  #   else
  #     # Default to easy
  #   end
  # end
end
