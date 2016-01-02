json.array!(@recipes) do |recipe|
  json.extract! recipe, :id, :precipIntensityStart, :precipIntensityEnd, :precipProbabilityStart, :precipProbabilityEnd, :precipType, :temperature, :apparentTemperature, :windSpeed, :humidity, :pressure
  json.url recipe_url(recipe, format: :json)
end
