class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :recipes, :precipInsensityStart, :precipIntensityStart
  end
end
