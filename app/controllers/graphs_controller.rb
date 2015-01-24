class GraphsController < ApplicationController

  def index
    @players = Player.all
  end

  def apply
    @player = Player.find(params[:player_id]).first
    @completed_games = Game.all.select{|g| g.complete?}.select{|g| g.players.to_a.include? @player}

   @games_by_date = @completed_games.group_by{|game|
     game.created_at.to_date
   }.map{|d,g|
     [d, g.count]
   }
  end

end
