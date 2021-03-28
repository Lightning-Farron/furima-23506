class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:edit, :update, :show, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @items = Item.includes(:user).order("created_at DESC")
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
    if @item.update(item_params)
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

  private

  def item_params
    params.require(:items_tag).permit(:name, :description, :category_id, :condition_id, :shipping_charge_id, :prefecture_id, :pays_to_ship_id, :price, :tag_name, images: []).merge(user_id: current_user.id)
  end
#タグの編集
  # def edit_params
  #   params.require(:item).permit(:name, :description, :category_id, :condition_id, :shipping_charge_id, :prefecture_id, :pays_to_ship_id, :price, images: []).merge(user_id: current_user.id)
  # end
  
  def set_item
    @item = Item.find(params[:id])
#タグの編集
    # @item_tag_relations = @item.item_tag_relations
    # @item_tag_relations.each do |item_tag_relation|
    #   tag = Tag.find(item_tag_relation.tag_id)
    # end
  end

  def ensure_correct_user
    if current_user.id != @item.user_id || @item.order != nil
      redirect_to root_path
    end
  end

end
