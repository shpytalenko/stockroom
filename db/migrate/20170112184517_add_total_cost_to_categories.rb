class AddTotalCostToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :total_cost, :integer, :null => false, :default => 0
  end
end
