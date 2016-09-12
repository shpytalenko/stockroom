class AddItemsCountToCategories < ActiveRecord::Migration

  def self.up

    add_column :categories, :items_count, :integer, :null => false, :default => 0

  end

  def self.down

    remove_column :categories, :items_count

  end

end
