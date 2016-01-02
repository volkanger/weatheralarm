json.array!(@locations) do |location|
  json.extract! location, :id, :lat, :long, :zipcode
  json.url location_url(location, format: :json)
end
