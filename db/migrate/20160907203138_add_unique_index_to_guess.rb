class AddUniqueIndexToGuess < ActiveRecord::Migration
  def change
    add_index :guesses, [:game_id, :attempt], unique: true
  end
end
