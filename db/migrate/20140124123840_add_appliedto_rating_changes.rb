class AddAppliedtoRatingChanges < ActiveRecord::Migration
  def change
    add_column :rating_changes, :applied, :boolean, default: false
  end
end
