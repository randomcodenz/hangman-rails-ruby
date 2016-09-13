class CreateGuesses < ActiveRecord::Migration
  def change
    create_table :guesses do |t|
      #REVIEW: null: false => required: true
      t.string :attempt, null: false
      #REVIEW: foreign_key: {on_delete: :cascade}
      t.references :game, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
