class Transaction < ActiveRecord::Base
  belongs_to :item
  belongs_to :target
  belongs_to :user
  
end
