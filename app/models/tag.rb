class Tag < ApplicationRecord
  has_many :item_tags
  has_many :items, through: :item_tags
  validates :tag_name,  uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    ["tag_name"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["item_tags", "items"]
  end
  
end
