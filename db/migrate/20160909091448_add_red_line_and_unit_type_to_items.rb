class AddRedLineAndUnitTypeToItems < ActiveRecord::Migration
  def change
    add_column :items, :red_line, :integer ,:null => false, :default => 0
    add_column :items, :unit_type, :string
  end
end
