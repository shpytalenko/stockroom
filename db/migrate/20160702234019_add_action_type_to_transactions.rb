class AddActionTypeToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :action_type, :string
  end
end
