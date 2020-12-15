class MessageChannel < ApplicationCable::Channel
  def subscribed
    question = Question.find(params[:id])
    stream_for question
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
