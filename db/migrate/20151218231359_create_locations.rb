class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.decimal :lat
      t.decimal :long
      t.string :zipcode

      t.timestamps null: false
    end
  end
end
