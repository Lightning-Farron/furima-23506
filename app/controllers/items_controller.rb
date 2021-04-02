class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:edit, :update, :show, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  before_action :set_search, only: [:index, :item_search, :show]

  def index
    @items = Item.includes(:user).order("created_at DESC")
    set_item_column
  end

  def new
    @item_tag = ItemsTag.new
  end

  def create
      @item_tag = ItemsTag.new(item_params)
      if @item_tag.valid?
        @item_tag.save
        redirect_to root_path
      else

        render :new
      end
  end

  def edit
  end

  def update
    if @item.update(edit_params)
      redirect_to root_path
    else
      render :edit
    end
    #タグの編集
    # @item_tag = ItemsTag.update(edit_params)
    # if @item_tag.valid?
    #   @item_tag.save
    #   redirect_to root_path
    # else
    #   render :edit
    # end
  end

  def show
    set_item_column
  end

  def destroy
    if @item.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  def search
    return nil if params[:keyword] == ""
    tag = Tag.where(['tag_name LIKE ?', "%#{params[:keyword]}%"] )
    render json:{ keyword: tag }
  end

  def item_search
    @results = @p.result#.includes(:user)  # 検索条件にマッチした商品の情報を取得
    #@items = Item.includes(:user).order("created_at DESC")
  end

  private

  def item_params
    params.require(:items_tag).permit(:name, :description, :category_id, :condition_id, :shipping_charge_id, :prefecture_id, :pays_to_ship_id, :price, :tag_name, images: []).merge(user_id: current_user.id)
  end

  def edit_params
    params.require(:item).permit(:name, :description, :category_id, :condition_id, :shipping_charge_id, :prefecture_id, :pays_to_ship_id, :price, images: []).merge(user_id: current_user.id)
  end
  
  def set_item
    @item = Item.find(params[:id])
#タグの編集
    # @item_tag_relations = @item.item_tag_relations
    # @item_tag_relations.each do |item_tag_relation|
    #   tag = Tag.find(item_tag_relation.tag_id)
    # end
#タグの編集    
  end

  def ensure_correct_user
    if current_user.id != @item.user_id || @item.order != nil
      redirect_to root_path
    end
  end

  def set_search
    @p = Item.ransack(params[:q])  # 検索オブジェクトを生成
  end

  def set_item_column
    @item_name = Item.select("name").distinct  # 重複なくnameカラムのデータを取り出す
    @item_category = Item.select("category").distinct
    @item_condition = Item.select("condition").distinct
  end
end
