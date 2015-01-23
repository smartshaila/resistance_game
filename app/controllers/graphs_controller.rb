class GraphsController < ApplicationController

  def index
    @players = Player.all
  end

  def apply
    @person = Player.find(params[:player_id])
    logger.info "*** #@person"
    @completed_games = Game.all.select{|g| g.complete?}.select{|g| g.players.to_a.include? @person}

#    @games_by_date = @completed_games.group_by{|game|
#      game.created_at.to_date
#    }.map{|d,g|
#      [d, g.count]
#    }
  end

end
