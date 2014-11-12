json.array!(@games) do |game|
  json.extract! game, :id, :date, :public_vote, :public_lancelot_switch
  json.url game_url(game, format: :json)
end
