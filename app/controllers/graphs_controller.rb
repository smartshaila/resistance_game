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
#   Game level filters
    date_filter = params[:filter_game_date].to_date
    public_vote_filter = nil

    if params[:filter_game_public_vote] == 'yes_public_vote'
      public_vote_filter = true
    elsif params[:filter_game_public_vote] == 'no_public_vote'
      public_vote_filter = false
    end

#   Player assignment filters
    @pa_filter = params['player_assignments']['player_id'].zip(
        params['player_assignments']['role_id'],
        params['player_assignments']['faction_id']).map {|f|
      {player: (f[0].empty? ? nil : Player.find(f[0])),
       role: (f[1].empty? ? nil : Role.find(f[1])),
       faction: (f[2].empty? ? nil : Faction.find(f[2]))
      }
    } unless @pa_filter.nil?

    @completed_games = Game.all.select{|g| g.complete? and
        (public_vote_filter.nil? or g.public_vote == public_vote_filter) and
        (date_filter.nil? or g.created_at.to_date == date_filter)
    }

    @completed_games = @completed_games.select{|g|
      @pa_filter.all? {|f|
        g.player_assignments.any? {|pa|
          (f[:player].nil? or pa.player == f[:player]) and
          (f[:role].nil? or pa.role == f[:role]) and
          (f[:faction].nil? or pa.faction == f[:faction])
        }
      }
    } unless @pa_filter.nil?

    @graph_type = :column
    @graph_data = []
    @graph_grouping = params[:graph_grouping].to_sym

    @graph_data = perspective_data(@completed_games, params[:graph_perspective], params[:perspective]).group_by{|pa|
      pa[:win]
    }.map{|result, assignment|
      {
          name: result ? 'Wins' : 'Losses',
          data: assignment.group_by{|a|
            get_grouping_label(@graph_grouping, a[@graph_grouping])
          }.map{|grouping, assignments|
            [grouping, assignments.count]
          }.sort
      }
    }.sort_by{|r| r[:name]}
  end

  private

    def perspective_data (games, perspective_type, perspective_value)
      perspective_id = perspective_value[perspective_type]
      data = case perspective_type
        when 'player'
          Player.find(perspective_id)
        when 'role'
          Role.find(perspective_id)
        when 'faction'
          Faction.find(perspective_id)
        else
      end

      games.map{|g|
        g.player_assignments.select{|pa|
          case perspective_type
            when 'player'
              pa.player == data
            when 'role'
              pa.role == data
            when 'faction'
              pa.faction == data
            else
              true
          end
        }.map{|pa|
          {
            player: pa.player,
            player_count: g.players.size,
            role: pa.role,
            faction: pa.faction,
            win: pa.faction == g.winning_faction,
            win_method: g.win_method.capitalize
          }
        }
      }.flatten
    end

    def get_grouping_label (grouping, value)
      case grouping
        when :player, :role, :faction
          value.name
        when :player_count
          "#{value} players"
        when :win_method
          value
        else
      end
    end

    def set_params
      @player = Player.find(params[:player_id]) unless params[:player_id].nil?
      @role = Role.find(params[:role_id]) unless params[:role_id].nil?
    end

end