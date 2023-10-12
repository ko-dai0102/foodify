class ItemTag < ApplicationRecord
  belongs_to :item
  belongs_to :tag

  def self.ransackable_associations(auth_object = nil)
    ["item", "tag"]
  end
  
end
