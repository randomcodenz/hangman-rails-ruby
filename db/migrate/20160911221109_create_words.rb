class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :word, null: false
      t.integer :difficulty, null: false

      t.timestamps null: false
    end
    add_index :words, :word, unique: true
  end
end
