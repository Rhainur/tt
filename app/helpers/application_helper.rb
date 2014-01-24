module ApplicationHelper
  def display_most_recent_match_result(player)
    match = player.most_recent_match
    s = nil
    if(match.nil?)
      s = "<i>No matches played</i>".html_safe
    else
      if(match.winner_id == player.id)
        opponent = Player.find(match.loser_id)
        s = "<span class=\"label label-success\">Win</span> against #{opponent.name}".html_safe
      else
        opponent = Player.find(match.winner_id)
        s = "<span class=\"label label-danger\">Loss</span> against #{opponent.name}".html_safe
      end
    end
    s
  end

  def display_match_scores(player, match)
    game_scores = match.games.map{ |g| display_game_score(player, g) }
    game_scores.join(' ').html_safe
  end

  def display_game_score(player, game)
    self_score = 0;
    opponent_score = 0;
    game.scores.each do |s|
      if s.player_id == player.id
        self_score = s.score
      else
        opponent_score = s.score
      end
    end
    str = "<span class=\"label "
    if(self_score > opponent_score)
      str.concat "label-success"
    else
      str.concat "label-danger"
    end
    str.concat "\">#{self_score} - #{opponent_score}</span>"
    str
  end

  def display_rating_change(player, match)
    r = nil
    match.rating_changes.each do |rc|
      if rc.player_id == player.id
        r = rc
      end
    end
    if r.change > 0
      "<span class=\"glyphicon glyphicon-chevron-up\"></span> #{r.change}".html_safe
    else
      "<span class=\"glyphicon glyphicon-chevron-down\"></span> #{r.change.abs}".html_safe
    end
  end
end
