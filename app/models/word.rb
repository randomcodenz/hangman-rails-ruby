class Word < ActiveRecord::Base
  validates :word,
    presence: true,
    uniqueness: { case_sensitive: false }
  validates :difficulty,
    presence: true,
    numericality: { only_integer: true, greater_than: 0 }

  def calculate_difficulty
    # Loop through single letters in order of frequency until we get a match
    # Loop through bigrams trying letters in order of frequency
  end
end
