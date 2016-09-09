class GuessesController < ApplicationController
  def create
    game = Game.includes(:guesses).find(params[:game_id])

    guesses = guess_attempt.chars.map { |attempt| game.guesses.new(:attempt => attempt) }
    if game.save
      flash[:guess_correct] = guesses.all? { |guess| game.is_correct_guess?(guess) }
    else
      flash[:error] = collect_errors( guesses )
      invalid_guesses(guesses).each { |invalid_guess| game.guesses.delete(invalid_guess) }
      game.save
    end

    flash[:guess_attempt] = guess_attempt

    redirect_to game_path(game)
  end

  private

  def guess_attempt
    guess_params[:attempt]
  end

  def guess_params
    params.require(:guess).permit(:attempt)
  end

  def collect_errors(guesses)
    all_guess_errors = invalid_guesses(guesses)
      .collect { |guess| guess.errors.messages }

    guess_error_messages = {}
    all_guess_errors.inject(guess_error_messages) do |all_errors, guess_errors|
      merge_unique_errors(all_errors, guess_errors)
    end
  end

  def invalid_guesses(guesses)
    guesses.select(&:invalid?)
  end

  def merge_unique_errors(all_errors, guess_errors)
    guess_errors.each do |field, messages|
      field_errors = all_errors[field] || []
      all_errors[field] = field_errors.concat(messages).uniq
    end
  end
end
