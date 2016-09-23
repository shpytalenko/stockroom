class AddCostToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :cost, :integer
  end
end
