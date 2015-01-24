class GraphsController < ApplicationController

  def index
    @players = Player.all
  end

  def apply

    @player = Player.find(params[:player_id]).first unless params[:player_id].first.empty?
    @completed_games = Game.all.select{|g| g.complete?}
    unless @player.nil?
      @completed_games = @completed_games.select{|g| g.players.to_a.include? @player}
    end

    @graph_group = params[:graph_group].first

    if @graph_group == "win_loss"
      @graph_type = :bar
      @graph_data = @completed_games.group_by{|game|
        game.winning_faction
      }.map{|f,g|
        [f.name, g.count]
      }
    elsif @graph_group == "frequency"
      @graph_type = :line
      @graph_data = @completed_games.group_by{|game|
        game.created_at.to_date
      }.map{|d,g|
        [d, g.count]
      }
    end

  end

end

# @player_wins_by_team = @player.assignments.group_by{|a|
#   a.winning?
# }.map{|r,a|
#   {
#       name: r ? 'Wins' : 'Losses',
#       data: a.group_by{|a|
#         a.team.name
#       }.map{|team,assignments|
#         [team, assignments.count]
#       }.sort
#   }
# }.sort_by{|r| r[:name]}