class ChangeRefToMessages < ActiveRecord::Migration[6.0]
  def change
    remove_reference :messages, :question, null: false, foreign_key: true
    add_reference :messages, :question, foreign_key: true
  end
end
