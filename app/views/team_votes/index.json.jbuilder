json.array!(@team_votes) do |team_vote|
  json.extract! team_vote, :id, :approve, :team_id, :player_assignment_id
  json.url team_vote_url(team_vote, format: :json)
end
