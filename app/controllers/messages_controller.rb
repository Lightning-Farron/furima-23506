class MessagesController < ApplicationController

  def create
    @message = Message.create(message_params)
    #redirect_to "/items/#{message.item.id}"
    if @message.save
      ActionCable.server.broadcast 'message_channel', content: @message, user_name: current_user.nickname
    end
  end

  private
  def message_params
    params.require(:message).permit(:text).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
