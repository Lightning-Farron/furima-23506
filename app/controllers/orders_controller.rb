class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_order_address, only: [:index, :create]
  before_action :ensure_correct_user, only: [:index, :create]
  

  def index
    @order_address = OrderAddress.new
  end

  def create
    redirect_to new_card_path and return unless current_user.card.present?

    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    customer_token = current_user.card.customer_token
    Payjp::Charge.create(
      amount: @item.price,
      customer: customer_token,
      currency: 'jpy'
      )

    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      @order_address.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def set_order_address
    @item = Item.find(params[:item_id])
  end

  def ensure_correct_user
    if current_user.id == @item.user_id || @item.order != nil
      redirect_to root_path
    end
  end
end
