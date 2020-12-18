class Message < ApplicationRecord
  # User-Message
  belongs_to :user, foreign_key: 'sender_id'
  belongs_to :question

  def sender
    user
  end

  def receiver
    User.find(receiver_id)
  end
end
