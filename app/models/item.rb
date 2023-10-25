class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to :category1
  belongs_to :category2
  has_many :item_tags
  has_many :tags, through: :item_tags
  has_many :likes
  has_many :comments

  has_one_attached :image

  scope :latest, -> { order(created_at: :desc)}
  scope :old, -> {order(created_at: :asc)}
  
  def like_count
    likes.count
  end

  def self.ransackable_attributes(auth_object = nil)
    ["category1_id", "category2_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["item_tags", "tags"]
  end

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

end
