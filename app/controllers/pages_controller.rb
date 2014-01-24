class PagesController < ApplicationController
  def index
    @players = Player.all
  end

  def player
    @player = Player.find(params[:player_id])
  end

  def record
    if(request.post?)
      # Time to record a new match!
      match = Match.new
      match.match_date = Date.today#Date.parse(params[:match][:date])
      match.save
      
      # Grab the players
      player_1 = Player.find(params[:match][:player_1_id])
      player_2 = Player.find(params[:match][:player_2_id])

      # Record each game
      match.record_games(player_1, params[:player_1_scores], player_2, params[:player_2_scores])

      # Calculate winner
      player_1_wins = 0
      player_2_wins = 0
      match.games.each do |game|
        if(game.winner_id == player_1.id)
          player_1_wins += 1
        else
          player_2_wins += 1
        end
      end

      if(player_1_wins > player_2_wins)
        match.winner_id = player_1.id
        match.loser_id = player_2.id
      else
        match.winner_id = player_2.id
        match.loser_id = player_1.id
      end

      match.update_ratings
      match.save
      redirect_to "/" and return
    end
  end
end