json.data do
  json.array!(@shorturls) do |shorturl|
    json.extract! shorturl, :id, :original_url, :shorturl, :visits_count, :user_id
  end
end
