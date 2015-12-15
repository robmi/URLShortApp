json.data do
  json.array!(@shortvisits) do |shortvisit|
    json.extract! shortvisit, :id, :ip, :city, :state, :country
  end
end
