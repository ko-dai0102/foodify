class ItemForm
  include ActiveModel::Model
  attr_accessor :image, :category1_id, :category2_id, :user_id, :item_id, :tag_id, :tag_name, :id, :created_at, :updated_at, :selectedTags

  with_options presence: true do
    validates :image
    validates :category1_id
    validates :category2_id
    validates :user_id
  end

  def save(input_tags)
    item = Item.create(image:, category1_id:, category2_id:, user_id:)

    input_tags.each do |tag|
      tag_name = tag.strip
      new_tag = Tag.where(tag_name: tag_name).first_or_initialize
      new_tag.tag_name = tag_name  # タグ名を設定
      new_tag.save
      ItemTag.create(item_id: item.id, tag_id: new_tag.id)
    end
  end

  def update(params, item)
    item.item_tags.destroy_all
    tag_name = params.delete(:tag_name)
    tag = Tag.where(tag_name: tag_name).first_or_initialize if tag_name.present?
    tag.save if tag_name.present?
    item.update(params)
    ItemTag.create(item_id: item.id, tag_id: tag.id) if tag_name.present?
  end

end