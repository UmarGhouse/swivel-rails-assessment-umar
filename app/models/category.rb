class Category < ApplicationRecord
  belongs_to :vertical
  has_many :courses, dependent: :destroy

  accepts_nested_attributes_for :courses
end
