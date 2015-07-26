class BlogArticle < ActiveRecord::Base
  belongs_to :author, class_name: 'User', foreign_key: :author_id

  has_attached_file :image, default_url: "/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  validates :title,        presence: true
  validates :body,         presence: true
  validates :author_id,    presence: true
  validates :image,        attachment_presence: true

  def to_param
    [id, title.parameterize].join('-')
  end
end
