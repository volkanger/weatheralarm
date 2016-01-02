class AddRangeToColumns < ActiveRecord::Migration
  def change
    rename_column :recipes, :temperature, :temperatureStart
    add_column :recipes, :temperatureEnd, :integer
    rename_column :recipes, :apparentTemperature, :apparentTemperatureStart
    add_column :recipes, :apparentTemperatureEnd, :integer
    rename_column :recipes, :windSpeed, :windSpeedStart
    add_column :recipes, :windSpeedEnd, :integer
    rename_column :recipes, :humidity, :humidityStart
    add_column :recipes, :humidityEnd, :decimal
    rename_column :recipes, :pressure, :pressureStart
    add_column :recipes, :pressureEnd, :integer
    add_column :recipes, :active, :boolean
  end
end
