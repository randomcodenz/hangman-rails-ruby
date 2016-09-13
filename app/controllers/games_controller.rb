class GamesController < ApplicationController
  DEFAULT_LIVES = 5
  DEFAULT_WORD = 'Powershop'

  # index, show, new, create, edit, update, destroy

  def show
    @game = Game.includes(:guesses).find(params[:id])
  end

  def create
    #REVIEW: Should be create! or if @game.save redirect else handle error (redirect to home page with oops)
    @game = Game.new(:word => DEFAULT_WORD, :initial_lives => DEFAULT_LIVES)
    @game.save

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
