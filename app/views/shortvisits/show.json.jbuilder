json.data do
  json.extract! @shortvisit, :id, :ip, :city, :state, :country, :created_at, :updated_at
end
