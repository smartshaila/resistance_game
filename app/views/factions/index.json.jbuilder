json.array!(@factions) do |faction|
  json.extract! faction, :id, :name
  json.url faction_url(faction, format: :json)
end
