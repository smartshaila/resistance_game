json.array!(@lancelots) do |lancelot|
  json.extract! lancelot, :id, :switched, :mission_id
  json.url lancelot_url(lancelot, format: :json)
end
