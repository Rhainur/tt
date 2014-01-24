class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.belongs_to(:match, index: true)
      t.integer :winner_id
    end
  end
end
