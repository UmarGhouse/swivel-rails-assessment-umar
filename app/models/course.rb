class Course < ApplicationRecord
  searchkick
  
  validates_presence_of :name
  
  belongs_to :category
end
