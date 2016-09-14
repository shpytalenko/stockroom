class Transaction < ActiveRecord::Base
  paginates_per 20
  
  belongs_to :item
  belongs_to :target
  belongs_to :user
  
end
