class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :timeline]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:show]
  before_action :redirect_to_show, only: [:edit, :update]

  def index
    @items = Item.includes(:likes, :comments).order(created_at: :desc)
  end
  
  def timeline
    followers = current_user.followings
  
    # フォロー中のユーザーのIDの配列を取得
    following_user_ids = followers.pluck(:id)
  
    # フォロー中のユーザーと自分の投稿を取得
    @items = Item.where(user_id: following_user_ids + [current_user.id])
                .includes(:user, :image_attachment, :likes, :comments)
                .order(created_at: :desc)
  
    @today = Date.today # 今日の日付を取得
    @now = Time.now     # 現在時刻を取得
  end

  def search
    @q = Item.ransack(params[:q])
    @items = @q.result(distinct: true).includes(:item_tags, :tags, :likes, :comments).order('RAND()')

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
    input_tags = tag_params[:tag_hidden].split(',')
    @item_form.save(input_tags)
    redirect_to root_path
  end

  def show
    @comments = @item.comments.includes(:user)
    @comment = Comment.new
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
    @item.likes.destroy_all # 関連するいいねを削除
    @item.item_tags.destroy_all # 関連するアイテムタグを削除
    @item.destroy # アイテムを削除
    redirect_to root_path
  end

  def tag_show
    return nil if params[:keyword].blank?
    tag_content = params[:keyword].split(',')  # カンマで区切られた文字列を配列に変換
    render json: { tag_content: tag_content }
  end

  def incremental
    return nil if params[:keyword] == ""
    tag = Tag.where(['tag_name LIKE ?', "%#{params[:keyword]}%"] )
    render json:{ keyword: tag }
  end


  private

  def item_params
    params.require(:item_form).permit(:category1_id, :category2_id, :image).merge(user_id: current_user.id)
  end

  def tag_params
    params.require(:item_form).permit(:tag_hidden)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_user
    @user = User.find(@item.user_id)
  end

  def redirect_to_show
    return redirect_to root_path if current_user.id != @item.user.id
  end
  
end
