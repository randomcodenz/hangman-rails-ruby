class GamesController < ApplicationController
  DEFAULT_LIVES = 5
  DEFAULT_WORD = 'Powershop'

  # index, show, new, edit, create, update, destroy

  def show
    # @game = Game.find(params[:id])
  end

  def create
    # No new method at this time as there are no parameters to pass to create a game
    @game = Game.new( { :word => DEFAULT_WORD, :initial_lives => DEFAULT_LIVES } )
    @game.save

    redirect_to @game
  end
end
