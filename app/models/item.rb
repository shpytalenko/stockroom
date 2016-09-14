class Item < ActiveRecord::Base
  paginates_per 20
  has_many :transactions, dependent: :destroy
  
  belongs_to :category
  counter_culture :category
  def total
    total = self.amount*self.price
  end
end
