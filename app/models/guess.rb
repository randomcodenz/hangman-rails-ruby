class Guess < ActiveRecord::Base
  belongs_to :game
  #TODO: Formatting?
  validates :attempt,
    presence: true,
    uniqueness: { case_sensitive: false, message: 'That guess has already been tried' }
end
