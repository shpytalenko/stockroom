class Transaction < ActiveRecord::Base
  paginates_per 20
  before_save :set_cost

  def set_cost
    self.cost = self.item.price*self.amount
  end 
 
  belongs_to :item
  belongs_to :target
  belongs_to :user
  
end
