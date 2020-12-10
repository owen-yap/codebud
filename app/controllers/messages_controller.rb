class MessagesController < ApplicationController

  def create
  @chatroom = Chatroom.find(params[:chatroom_id])
  @message = Message.new(params_message)
  @message.chatroom = @chatroom
  @message.user = current_user
    if @message.save
      raise
      redirect_to chatroom_path(@chatroom, anchor: "message-#{@message.id}")
    else
      render "chatrooms/show"
    end
  end

  private

  def params_message
    params.require(:message).permit(:content, :sender_id)
  end

end
