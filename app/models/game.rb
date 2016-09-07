class Game < ActiveRecord::Base
  has_many :guesses
  validates_presence_of :word
  validates :initial_lives,
    presence: true,
    numericality: { only_integer: true, greater_than: 0 }
  validates_associated :guesses

  def get_masked_word
    word.chars.map { nil }
  end

  def is_correct_guess?(guess)
    #TODO: Ensure that guess is in guesses?
    word.chars.include? guess.attempt
  end
end
