class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.decimal :lat
      t.decimal :long
      t.integer :zipcode

      t.timestamps null: false
    end
  end
end
