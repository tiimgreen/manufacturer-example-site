class JobLocation < ActiveRecord::Base
  has_many :jobs

  validates :title, presence: true, length: { maximum: 100 }
end
