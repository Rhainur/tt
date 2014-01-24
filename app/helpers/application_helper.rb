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
end
