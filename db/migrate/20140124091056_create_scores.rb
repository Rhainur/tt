class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.belongs_to(:game, index: true)
      t.belongs_to(:player, index: true)
      t.integer :score

      t.timestamps
    end
  end
end
