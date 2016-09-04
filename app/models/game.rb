class Game < ActiveRecord::Base
  validates_presence_of :word
  validates :initial_lives, presence: true, numericality: { only_integer: true, greater_than: 0 }

  def get_masked_word
    word.chars.map { nil }
  end

end
