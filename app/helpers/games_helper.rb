module GamesHelper
  def render_masked_word(game)
    game.masked_letters
      .map { |masked_letter| render_letter(masked_letter) }
      .join(' ')
  end

  private

  def render_letter(masked_letter)
    masked_letter.nil? ? '_' : masked_letter
  end
end
