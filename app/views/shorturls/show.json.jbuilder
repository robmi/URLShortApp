json.data do
  json.extract! @shorturl, :id, :original_url, :shorturl, :visits_count, :user_id, :created_at, :updated_at
end
