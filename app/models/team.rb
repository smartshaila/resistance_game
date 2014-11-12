class Team < ActiveRecord::Base
  belongs_to :mission
  has_many :team_votes
  has_many :team_assignments
end
