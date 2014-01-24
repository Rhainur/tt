class RatingChange < ActiveRecord::Base
  belongs_to :player
  belongs_to :match
  def self.apply_ratings
    changes = RatingChange.includes(:player).where(applied: false).order("id ASC")
    changes.each do |c|
      c.player.rating += c.change
      c.player.save
    end
  end
end