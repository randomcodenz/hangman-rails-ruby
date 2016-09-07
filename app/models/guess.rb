class Guess < ActiveRecord::Base
  belongs_to :game
  #TODO: Formatting?
  validates :attempt,
    presence: true,
    uniqueness: { case_sensitive: false, message: 'That guess has already been tried' },
    format: { with: /\A[A-Za-z]{1}\z/, message: 'That guess is not valid' }
end
