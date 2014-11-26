class TeamVote < ActiveRecord::Base
  belongs_to :team
  belongs_to :player_assignment
  delegate :mission, to: :team
  delegate :game, to: :mission
end
