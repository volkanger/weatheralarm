class SetActiveDefault < ActiveRecord::Migration
  def change
    change_column :recipes, :active, :integer, default: 1
  end
end
