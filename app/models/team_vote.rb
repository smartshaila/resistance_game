class TeamVote < ActiveRecord::Base
  belongs_to :team
  belongs_to :player_assignment
end
