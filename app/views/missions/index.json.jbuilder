json.array!(@missions) do |mission|
  json.extract! mission, :id, :game_id
  json.url mission_url(mission, format: :json)
end
