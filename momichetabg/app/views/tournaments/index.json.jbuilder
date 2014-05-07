json.array!(@tournaments) do |tournament|
  json.extract! tournament, :id, :winner_id, :state, :start_time
  json.url tournament_url(tournament, format: :json)
end
