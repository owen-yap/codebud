class AddQuestionToMessages < ActiveRecord::Migration[6.0]
  def change
    add_reference :messages, :question, null: false, foreign_key: true
  end
end
