class Game < ActiveRecord::Base
  has_many :guesses, :dependent => :destroy
  validates_presence_of :word
  validates :initial_lives,
    numericality: { only_integer: true, greater_than: 0 }
  validates_associated :guesses
  # TODO: Add validation to game or guess to stop adding guesses when lives == 0?

  def incorrect_guesses
    guesses.select(&:valid?)
      .reject { |guess| is_correct_guess?(guess) }
      .collect(&:attempt)
  end

  def calculate_lives_remaining
    initial_lives - incorrect_guesses.length
  end

  # REVIEW: Could return an object that knows how to render itself that the view can exploit
  def masked_letters
    guess_attempts = guesses.collect(&:attempt).join
    word.chars.map { |char| guess_attempts.include?(char.downcase) ? char : nil }
  end

  def game_over?
    game_lost? || game_won?
  end

  def game_won?
    !game_lost? && masked_letters.all?(&:present?)
  end

  def game_lost?
    calculate_lives_remaining <= 0
  end

  def is_correct_guess?(guess)
    #TODO: Ensure that guess is in guesses?
    word.chars.include? guess.attempt
  end
end
