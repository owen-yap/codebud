class RemoveChatroomFromMessages < ActiveRecord::Migration[6.0]
  def change
    remove_reference :messages, :chatroom
  end
end
