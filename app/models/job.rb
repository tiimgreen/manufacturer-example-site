class Job < ActiveRecord::Base
  belongs_to :job_location

  validates :title,           presence: true, length: { maximum: 150 }
  validates :subtitle,        presence: true, length: { maximum: 150 }
  validates :body,            presence: true
  validates :apply_url,       presence: true
  validates :job_location_id, presence: true

  def to_param
    [id, title.parameterize].join('-')
  end
end
