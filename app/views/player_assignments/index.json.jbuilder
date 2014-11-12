json.array!(@player_assignments) do |player_assignment|
  json.extract! player_assignment, :id, :seat_number, :game_id, :player_id, :role_id
  json.url player_assignment_url(player_assignment, format: :json)
end
