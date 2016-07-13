class Item < ActiveRecord::Base
  has_many :transactions
  belongs_to :category
end
