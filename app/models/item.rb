class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to :category1
  belongs_to :category2
  has_many :item_tags
  has_many :tags, through: :item_tags
  #has_many :likes

  has_one_attached :image

  def self.ransackable_attributes(auth_object = nil)
    ["category1_id", "category2_id", "created_at", "id", "updated_at", "user_id"]
  end

end
