class Guess < ActiveRecord::Base
  belongs_to :game
  validates :attempt, presence: true
end
