class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.integer :active, default: 1
      t.string :name
      t.decimal :precipIntensityStart
      t.decimal :precipIntensityEnd
      t.decimal :precipProbabilityStart
      t.decimal :precipProbabilityEnd
      t.string :precipType
      t.integer :temperatureStart
      t.integer :temperatureEnd
      t.integer :apparentTemperatureStart
      t.integer :apparentTemperatureEnd
      t.integer :windSpeedStart
      t.integer :windSpeedEnd
      t.decimal :humidityStart
      t.decimal :humidityEnd
      t.integer :pressureStart
      t.integer :pressureEnd
      
      t.timestamps null: false
    end
  end
end
