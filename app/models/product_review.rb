class ProductReview < ActiveRecord::Base
  validates :name,   presence: true
  validates :review, presence: true
  validates :number, inclusion: 1..5
end
