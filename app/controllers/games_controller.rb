class GamesController < ApplicationController
  DEFAULT_LIVES = 5
  DEFAULT_WORD = 'Powershop'

  # index, show, new, create, edit, update, destroy

  def show
    @game = Game.includes(:guesses).find(params[:id])
  end

  def create
    word = random_word(game_params[:difficulty], DEFAULT_LIVES)
    @game = Game.create!(:word => word, :initial_lives => DEFAULT_LIVES)
    redirect_to @game
  end

  private

  def game_params
    params.permit(:game_difficulty)
  end

  def random_word(difficulty, initial_lives)
    all_words =
      case difficulty
      when "medium"
        Word.medium_difficulty(initial_lives)
      when "hard"
        Word.hard_difficulty(initial_lives)
      when "expert"
        Word.expert_difficulty(initial_lives)
      else
        # Default to easy
        Word.easy_difficulty(initial_lives)
      end
      all_words.sample.word
  end
end
