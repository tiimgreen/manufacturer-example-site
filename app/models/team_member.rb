class TeamMember < ActiveRecord::Base
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  validates :first_name, presence: true
  validates :last_name,  presence: true
  validates :job_title,  presence: true
  validates :order,      presence: true
  validates :avatar,     attachment_presence: true

  def name
    "#{first_name} #{last_name}"
  end

  def to_param
    [id, first_name.parameterize, last_name.parameterize].join('-')
  end
end
