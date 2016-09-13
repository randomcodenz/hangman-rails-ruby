class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      #REVIEW: Limits should be applied to string columns
      t.string :word, null: false
      t.integer :initial_lives, null: false

      t.timestamps null: false
    end
  end
end
