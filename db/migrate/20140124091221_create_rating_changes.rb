class CreateRatingChanges < ActiveRecord::Migration
  def change
    create_table :rating_changes do |t|
      t.belongs_to(:match, index: true)
      t.belongs_to(:player, index: true)
      t.integer :change

      t.timestamps
    end
  end
end
