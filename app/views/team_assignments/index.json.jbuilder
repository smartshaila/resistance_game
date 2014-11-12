json.array!(@team_assignments) do |team_assignment|
  json.extract! team_assignment, :id, :pass, :team_id, :player_assignment_id
  json.url team_assignment_url(team_assignment, format: :json)
end
