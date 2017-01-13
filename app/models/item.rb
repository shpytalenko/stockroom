class Item < ActiveRecord::Base
  paginates_per 20
  has_many :transactions, dependent: :destroy
  before_save :update_total 
  belongs_to :category
  counter_culture :category
  counter_culture :category, :column_name => 'total_cost', :delta_column => 'total'
  def get_total
    total = self.amount*self.price
  end
  
  def self.total_sum
    sum(:total)
  end
  
  private
  def update_total
    self[:total] = get_total
  end
end
