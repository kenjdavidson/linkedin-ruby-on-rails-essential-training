class PageAssignment < ApplicationRecord
  ROLES = ['manager','editor']
  
  belongs_to :page
  belongs_to :user
end
