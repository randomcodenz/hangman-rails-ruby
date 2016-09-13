class Word < ActiveRecord::Base
  validates :word,
    presence: true,
    uniqueness: { case_sensitive: false }
  validates :difficulty,
    presence: true,
    numericality: { only_integer: true, greater_than: 0 }

  before_validation :calculate_difficulty, if: :missing_difficulty?

  def self.easy_difficulty(game_lives)
    where("difficulty < ?", game_lives)
  end

  def self.medium_difficulty(game_lives)
    min_difficulty = game_lives
    max_difficulty = game_lives * 2
    where("difficulty >= ? AND difficulty < ?", min_difficulty, max_difficulty)
  end

  def self.hard_difficulty(game_lives)
    min_difficulty = game_lives * 2
    max_difficulty = game_lives * 3
    where("difficulty >= ? AND difficulty < ?", min_difficulty, max_difficulty)
  end

  def self.expert_difficulty(game_lives)
    min_difficulty = game_lives * 3
    where("difficulty >= ?", min_difficulty)
  end

  private

  def missing_difficulty?
    difficulty.nil?
  end

  def calculate_difficulty
    self.difficulty = GuessBot.calculate_guesses(word).length
  end
end
