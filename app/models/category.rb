class Category < ApplicationRecord
  searchkick
  
  validates_uniqueness_of :name
  validates_with CategoryValidator

  belongs_to :vertical
  has_many :courses, dependent: :destroy

  accepts_nested_attributes_for :courses
end
