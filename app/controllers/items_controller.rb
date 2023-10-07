class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :redirect_to_show, only: [:edit, :update]
  before_action :ransack_set, only: [:index, :search]

  def index
    if params[:category1_id].present?
      category1 = Category1.find_by(id: params[:category1_id])
      @items = @items.where(category1_id: category1.id)
    end

    if params[:category2_id].present?
      category2 = Category2.find_by(id: params[:category2_id])
      @items = @items.where(category2_id: category2.id)
    end

    if params[:tag_name].present?
      tag = Tag.find_by(tag_name: params[:tag_name])
      @items = tag ? tag.items : []
    end
  end

  def new
    @item_form = ItemForm.new
  end

  def create
    @item_form = ItemForm.new(item_params)
    if @item_form.valid?
      @item_form.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
    item_attributes = @item.attributes
    @item_form = ItemForm.new(item_attributes)
    @item_form.tag_name = @item.tags.first&.tag_name
  end

  def update
    @item_form = ItemForm.new(item_params)
    @item_form.image ||= @item.image.blob
    if @item_form.valid?
      @item_form.update(item_params, @item)
      redirect_to item_path(@item.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.item_tags.destroy_all
    @item.destroy
    redirect_to root_path
  end
  
  def search
  end

  def incremental
    return nil if params[:keyword] == ""
    tag = Tag.where(['tag_name LIKE ?', "%#{params[:keyword]}%"] )
    render json:{ keyword: tag }
  end

  private

  def item_params
    params.require(:item_form).permit(:category1_id, :category2_id, :tag_name, :image).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def redirect_to_show
    return redirect_to root_path if current_user.id != @item.user.id
  end

  def ransack_set
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true)
  end
  
end
