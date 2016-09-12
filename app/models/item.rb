class Item < ActiveRecord::Base
  has_many :transactions, dependent: :destroy
  belongs_to :category
  counter_culture :category
  def total
    total = self.amount*self.price
  end
end
