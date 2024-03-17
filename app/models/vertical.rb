class Vertical < ApplicationRecord
  searchkick
  
  validates_uniqueness_of :name
  validates_with VerticalValidator

  # Validate nested categories on save
  validates_associated :categories

  has_many :categories, dependent: :destroy

  accepts_nested_attributes_for :categories
end
