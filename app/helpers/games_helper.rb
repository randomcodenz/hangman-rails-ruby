module GamesHelper
  def masked_word(masked_letters)
    masked_letters
      .map { |masked_letter| render_letter(masked_letter) }
      .join(' ')
  end

  def guess_attempt(guess_attempt)
    ConditionalPartial.new('guess_attempt', guess_attempt)
  end

  def guess_result(guess_correct, guess_attempt)
      partial_name = guess_correct ? 'guess_correct' : 'guess_incorrect'
      partial = ConditionalPartial.new(partial_name, guess_correct)

      { :partial => partial, :locals => { :guess_attempt => guess_attempt } }
  end

  def incorrect_guesses(incorrect_guesses)
    ConditionalPartial.new('incorrect_guesses', incorrect_guesses)
      .render_if(incorrect_guesses.any?)
  end

  def game_over(game)
    partial_name = game.game_won? ? 'game_won' : 'game_lost'
    partial = ConditionalPartial.new(partial_name).render_if(game.game_over?)

    { :partial => partial, :locals => { :word => game.word } }
  end

  def game_in_progress(game)
    partial = ConditionalPartial.new('game_in_progress', game)
      .render_unless(game.game_over?)

    { :partial => partial, :as => :game }
  end

  private

  def render_letter(masked_letter)
    masked_letter.nil? ? '_' : masked_letter
  end
end
