class GuessesController < ApplicationController
  def create
    game = Game.find(params[:game_id])

    guess = game.guesses.new(guess_params)
    flash[:guess_attempt] = guess.attempt

    if game.save
      flash[:guess_correct] = game.is_correct_guess?(guess)
    else
      flash[:error] = guess.errors.messages
    end

    redirect_to game_path(game)
  end

  private

  def guess_params
    params.require(:guess).permit(:attempt)
  end
end
