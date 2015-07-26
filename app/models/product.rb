class Product < ActiveRecord::Base
  has_many :product_specifications, dependent: :destroy
  has_many :product_images,         dependent: :destroy
  has_many :product_reviews,        dependent: :destroy

  validates :name,         presence: true, length: { maximum: 250 }
  validates :user_id,      presence: true
  validates :introduction,                 length: { maximum: 250 }

  def to_param
    [id, name.parameterize].join('-')
  end
end
