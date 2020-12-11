class RemoveChatrooms < ActiveRecord::Migration[6.0]
  def change
    drop_table(:chatrooms)
  end
end
