json.array!(@mission_capacities) do |mission_capacity|
  json.extract! mission_capacity, :id, :player_count, :mission_number, :capacity, :fail_count
  json.url mission_capacity_url(mission_capacity, format: :json)
end
