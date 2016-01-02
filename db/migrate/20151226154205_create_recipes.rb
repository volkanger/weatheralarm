class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.decimal :precipInsensityStart
      t.decimal :precipIntensityEnd
      t.decimal :precipProbabilityStart
      t.decimal :precipProbabilityEnd
      t.string :precipType
      t.integer :temperature
      t.integer :apparentTemperature
      t.integer :windSpeed
      t.decimal :humidity
      t.integer :pressure

      t.timestamps null: false
    end
  end
end
