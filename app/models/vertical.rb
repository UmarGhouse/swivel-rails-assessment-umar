class Vertical < ApplicationRecord
  searchkick
  
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_with VerticalValidator

  has_many :categories, dependent: :destroy

  accepts_nested_attributes_for :categories
end
