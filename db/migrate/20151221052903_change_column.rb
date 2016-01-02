class ChangeColumn < ActiveRecord::Migration
  def change
    change_column :locations, :zipcode, :string
  end
end
