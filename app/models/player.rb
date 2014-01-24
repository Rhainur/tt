class Player < ActiveRecord::Base
  has_many :matches
  has_many :rating_changes

  def self.create_player(name)
    p = Player.new
    p.name = name
    p.rating = 1500
    p.save
    p
  end

  def most_recent_match
    m = Match.where("winner_id = ? OR loser_id = ?", self.id, self.id).order("id DESC").take(1).first
  end

  def recent_matches
    Match.includes(:rating_changes, games: :scores).where("winner_id = ? OR loser_id = ?", self.id, self.id).order("id DESC").take(10)
  end
end