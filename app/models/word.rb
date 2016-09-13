class Word < ActiveRecord::Base
  validates :word,
    presence: true,
    uniqueness: { case_sensitive: false }
  validates :difficulty,
    presence: true,
    numericality: { only_integer: true, greater_than: 0 }

  before_validation :calculate_difficulty, if: :missing_difficulty?

  private

  def missing_difficulty?
    difficulty.nil?
  end

  def calculate_difficulty
    self.difficulty = GuessBot.calculate_guesses(word).length
  end
end
