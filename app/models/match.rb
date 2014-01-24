class Match < ActiveRecord::Base
  has_many :games, dependent: :destroy
  has_many :rating_changes, dependent: :destroy

  def record_games(player_1, scores_1, player_2, scores_2)
    scores_1.each do |game, score|
      self.record_game(player_1, score.to_i, player_2, scores_2[game].to_i)
    end
  end

  def record_game(player_1, score_1, player_2, score_2)
    unless(score_1 > 0 && score_2 > 0)
      return
    end

    g = self.games.create

    g.scores.create(score: score_1, player_id: player_1.id)
    g.scores.create(score: score_2, player_id: player_2.id)

    if(score_1 > score_2)
      g.winner_id = player_1.id
      g.loser_id = player_2.id
    else
      g.winner_id = player_2.id
      g.loser_id = player_1.id
    end

    g.save
    g
  end

  def update_ratings
    winner = Player.find(self.winner_id)
    loser = Player.find(self.loser_id)

    points_exchanged = 0

    point_spread = winner.rating - loser.rating

    if(point_spread > 0) # Higher rated player wins
      case point_spread.abs
      when 0..12
        points_exchanged = 8
      when 13..37
        points_exchanged = 7
      when 38..62
        points_exchanged = 6
      when 63..87
        points_exchanged = 5
      when 88..112
        points_exchanged = 4
      when 113..137
        points_exchanged = 3
      when 138..187
        points_exchanged = 2
      when 188..237
        points_exchanged = 1
      else
        points_exchanged = 0
      end
    else # Lower rated player wins
      case point_spread.abs
      when 0..12
        points_exchanged = 8
      when 13..37
        points_exchanged = 10
      when 38..62
        points_exchanged = 13
      when 63..87
        points_exchanged = 16
      when 88..112
        points_exchanged = 20
      when 113..137
        points_exchanged = 25
      when 138..162
        points_exchanged = 30
      when 163..187
        points_exchanged = 35
      when 188..212
        points_exchanged = 40
      when 213..237
        points_exchanged = 45
      else
        points_exchanged = 50
      end
    end

    self.rating_changes.create(player_id: self.winner_id, change: points_exchanged, applied: false)
    self.rating_changes.create(player_id: self.loser_id, change: points_exchanged * -1, applied: false)
  end
end