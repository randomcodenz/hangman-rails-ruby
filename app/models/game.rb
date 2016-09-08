class Game < ActiveRecord::Base
  has_many :guesses
  validates_presence_of :word
  validates :initial_lives,
    presence: true,
    numericality: { only_integer: true, greater_than: 0 }
  validates_associated :guesses

  def incorrect_guesses
    guesses.select(&:valid?)
      .reject { |guess| is_correct_guess?(guess) }
      .collect(&:attempt)
  end

  def calculate_lives_remaining
    initial_lives - incorrect_guesses.length
  end

  def get_masked_word
    guess_attempts = guesses.collect(&:attempt).join
    word.chars.map { |char| guess_attempts.include?(char.downcase) ? char : nil }
  end

  def is_correct_guess?(guess)
    #TODO: Ensure that guess is in guesses?
    word.chars.include? guess.attempt
  end
end
