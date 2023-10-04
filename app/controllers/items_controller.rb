class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :set_item, only: [:show, :edit, :update]
  before_action :redirect_to_show, only: [:edit, :update]

  def index
    @q = Item.ransack(params[:q])
    @items = @q.result
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
  end

  def update
    # paramsの内容を反映したインスタンスを生成する
    @item_form = ItemForm.new(item_params)

    # 画像を選択し直していない場合は、既存の画像をセットする
    @item_form.image ||= @item.image.blob

    if @item_form.valid?
      @item_form.update(item_params, @item)
      redirect_to item_path(@item.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
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
end
