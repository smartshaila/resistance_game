class TeamVote < ActiveRecord::Base
  belongs_to :team
  belongs_to :player_assignment
  belongs_to :mission, through: :team
  belongs_to :game, through: :mission
end
