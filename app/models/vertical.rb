class Vertical < ApplicationRecord
  has_many :categories, dependent: :destroy
end
