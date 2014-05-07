json.array!(@battles) do |battle|
  json.extract! battle, :id, :oponent1_id, :oponent2_id, :oponent1_votes, :oponent2_votes
  json.url battle_url(battle, format: :json)
end
