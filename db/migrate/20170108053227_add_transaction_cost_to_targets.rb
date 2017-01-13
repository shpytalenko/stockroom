class AddTransactionCostToTargets < ActiveRecord::Migration

  def self.up

    add_column :targets, :transaction_cost, :integer, :null => false, :default => 0

  end

  def self.down

    remove_column :targets, :transaction_cost

  end

end
