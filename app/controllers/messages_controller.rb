class MessagesController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @message = Message.new
  end

  def create
    @receiver = User.find(params[:user_id])
    @message = Message.new(params_message)
    @message.receiver_id = @receiver.id
    @message.sender_id = current_user.id
      if @message.save
        MessageChannel.broadcast_to(
          @receiver,
          render_to_string(partial: "message", locals: { message: @message })
        )
        redirect_to user_messages_path(@receiver, anchor: "message-#{@message.id}")
      else
        render "/index"
      end
  end


  private

  def params_message
    params.require(:message).permit(:content)
  end

end
