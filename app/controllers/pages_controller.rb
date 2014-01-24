class PagesController < ApplicationController
  def index
    @players = Player.all
  end

  def record
    
  end
end