class AddUniqueIndexToGuess < ActiveRecord::Migration
  def change
    add_index :guesses, :attempt, unique: true
  end
end
