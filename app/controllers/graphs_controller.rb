class GraphsController < ApplicationController
  before_action :set_params, only: [:index, :apply]
  layout 'player'

  def index
    @players = Player.all
    @roles = Role.all
    @factions = Faction.all
    @games = Game.all
  end

  def apply

    pa_filters = params['player_assignments']['player_id'].zip(
        params['player_assignments']['role_id'],
        params['player_assignments']['faction_id']).map {|f|
      {player: (f[0].empty? ? nil : Player.find(f[0])),
       role: (f[1].empty? ? nil : Role.find(f[1])),
       faction: (f[2].empty? ? nil : Faction.find(f[2]))
      }
    }

    @completed_games = Game.all.select{|g| g.complete?}
    @completed_games = @completed_games.select{|g|
      pa_filters.all? {|f|
        g.player_assignments.any? {|pa|
          (f[:player].nil? or pa.player == f[:player]) and
          (f[:role].nil? or pa.role == f[:role]) and
          (f[:faction].nil? or pa.faction == f[:faction])
        }
      }
    }

#    @graph_group = params[:graph_group]

#    if @graph_group == "win_loss"
      @graph_type = :bar
      @graph_data = @completed_games.group_by{|game|
        game.winning_faction
      }.map{|f,g|
        [f.name, g.count]
      }
#    elsif @graph_group == "frequency"
#      @graph_type = :line
#      @graph_data = @completed_games.group_by{|game|
#        game.created_at.to_date
#      }.map{|d,g|
#        [d, g.count]
#      }
#    end

  end

  private

    def set_params
      @player = Player.find(params[:player_id]) unless params[:player_id].nil?
      @role = Role.find(params[:role_id]) unless params[:role_id].nil?
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