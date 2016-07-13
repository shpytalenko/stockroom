class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.string :sku
      t.text :description
      t.integer :price

      t.timestamps null: false
    end
  end
end
