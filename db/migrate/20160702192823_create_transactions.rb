class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :item_id
      t.string :type
      t.integer :amount
      t.integer :target_id
      t.text :notes

      t.timestamps null: false
    end
  end
end
