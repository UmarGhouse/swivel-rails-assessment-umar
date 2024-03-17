class Course < ApplicationRecord
  searchkick
  
  belongs_to :category
end
