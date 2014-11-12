json.array!(@ladies) do |lady|
  json.extract! lady, :id, :mission_id, :source_id, :target_id
  json.url lady_url(lady, format: :json)
end
