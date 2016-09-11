class Word < ActiveRecord::Base
  validates :word,
    presence: true,
    uniqueness: { case_sensitive: false }
  validates :difficulty,
    presence: true,
    numericality: { only_integer: true, greater_than: 0 }
end
