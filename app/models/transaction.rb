class Transaction < ActiveRecord::Base
  paginates_per 20
  before_save :set_cost, :set_category_id
  attr_accessor :item_category
  def set_cost
    self.cost = self.item.price*self.amount
  end 

  def set_category_id
    self.category_id = self.item.category_id
  end
  
  def item_category
    item.category.id
  end
  counter_culture :target, :column_name => 'transaction_cost', :delta_column => 'cost'
  belongs_to :item
  belongs_to :target
  belongs_to :user
  
  def self.total_in
    where(:action_type => "In").sum(:cost)
  end

  def self.total_out
    where(:action_type => "Out").sum(:cost)
  end
  
  def self.check_balance
     total_out + Item.total_sum - total_in
  end
  
  def self.report(transactions)
  
  
  
  end

end
