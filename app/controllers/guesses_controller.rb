class GuessesController < ApplicationController
  def create
    game = Game.find(params[:game_id])
    guess_attempt = guess_params[:attempt]

    if game.already_tried?(guess_attempt)
      flash[:guess_outcome] = :already_tried
    else
      guess = game.guesses.create(guess_params)
      flash[:guess_outcome] = game.is_correct_guess?(guess) ? :correct : :incorrect
    end

    flash[:guess_attempt] = guess_attempt

    redirect_to game_path(game)
  end

  private

  def guess_params
    params.require(:guess).permit(:attempt)
  end
end
