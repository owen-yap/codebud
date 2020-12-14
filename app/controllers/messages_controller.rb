class MessagesController < ApplicationController

  def index
    # @user = User.find(params[:user_id])
    @question = Question.find(params[:question_id])
    @message = Message.new
  end

  def create
    @question = Question.find(params[:question_id])
    @receiver = @question.selected_proposal.user
    @message = Message.new(params_message)
    @message.receiver_id = @receiver.id
    @message.sender_id = current_user.id
    @message.question = @question

    if @message.save
      MessageChannel.broadcast_to(
        @question,
        render_to_string(partial: "message", locals: { message: @message })
      )
    else
      render "/index"
    end
  end

  private

  def params_message
    params.require(:message).permit(:content)
  end

end
