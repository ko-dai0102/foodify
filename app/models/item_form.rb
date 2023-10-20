class ItemForm
  include ActiveModel::Model
  attr_accessor :image, :category1_id, :category2_id, :user_id, :item_id, :tag_id, :tag_name, :id, :created_at, :updated_at, :selectedTags

  with_options presence: true do
    validates :image
    validates :category1_id
    validates :category2_id
    validates :user_id
  end

  def save
    item = Item.create(image:, category1_id:, category2_id:, user_id:)
    tag = Tag.where(tag_name:).first_or_initialize
    tag.save
    ItemTag.create(item_id: item.id, tag_id: tag.id)

    #selectedTags.each do |tag_name|
      #tag = Tag.where(tag_name:).first_or_initialize
      #tag.save
      #ItemTag.create(item_id: item.id, tag_id: tag.id)
    #end
  end

  def create_tags(input_tags)
    input_tags.each do |tag|                     # splitで分けたtagをeach文で取得する
      new_tag = Tag.find_or_create_by(name: tag) # tagモデルに存在していれば、そのtagを使用し、なければ新規登録する
      tags << new_tag                            # 登録するtopicのtagに紐づける（中間テーブルにも反映される）
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