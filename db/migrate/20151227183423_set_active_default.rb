class SetActiveDefault < ActiveRecord::Migration
  def change
    change_column :recipes, :activated, :integer, default: 1
  end
end
