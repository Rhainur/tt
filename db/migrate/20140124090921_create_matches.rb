class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.date :match_date
      t.integer :winner_id
      t.timestamps
    end
  end
end
