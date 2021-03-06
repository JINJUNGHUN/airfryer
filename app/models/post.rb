class Post < ApplicationRecord
  resourcify
  paginates_per 20

  has_many :ingredients, dependent: :destroy # 포스트를 삭제하면 ingredients도 같이 삭제 하겠다.
  accepts_nested_attributes_for :ingredients, allow_destroy: true

  has_many :steps, dependent: :destroy # 포스트를 삭제하면 steps도 같이 삭제 하겠다.
  accepts_nested_attributes_for :steps, allow_destroy: true

  has_many :post_attachments
  accepts_nested_attributes_for :post_attachments

  has_many :likes, dependent: :destroy

  belongs_to :category
  belongs_to :user

  mount_uploader :image, ImageUploader
  serialize :images, JSON # If you use SQLite, add this line.

  validates :title, presence: true, length: {minimum: 1}
  validates :description, presence: true, length: {minimum: 1}
  validates :temperature, presence: true, length: {minimum: 1}
  validates :time, presence: true, length: {minimum: 1}
  validates :image, presence:true, file_size: { less_than: 5.megabytes }

end
