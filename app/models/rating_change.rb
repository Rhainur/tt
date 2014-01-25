class RatingChange < ActiveRecord::Base
  belongs_to :player
  belongs_to :match

  def self.apply_ratings
    changes = RatingChange.includes(:player).where(applied: false).order("id ASC")
    changes.each do |c|
      c.player.rating += c.change
      c.player.save
      c.applied = true
      c.save
    end
  end

  def self.rollback_rating(rc)
    rc.player.rating -= rc.change
    rc.player.save
    rc.destroy
  end

  def self.rollback_ratings
    RatingChange.all.each do |rc|
      RatingChange.rollback_rating(rc)
    end
  end
end