class ItemForm
  include ActiveModel::Model
  attr_accessor :image, :category1_id, :category2_id, :user_id, :item_id, :tag_id, :tag_name, :id, :created_at, :updated_at

  with_options presence: true do
    validates :image
    validates :category1_id
    validates :category2_id
    validates :user_id
    #validates :item_id
    #validates :tag_id
    #validates :name
  end

  def save
    Item.create(image:, category1_id:, category2_id:, user_id:)
    if tag_name.present?
      tag = Tag.where(tag_name:).first_or_initialize
      tag.save
      ItemTag.create(item_id: item.id, tag_id: tag.id)
    end
  end

  def update(params, post)
    post.update(params)
  end

end