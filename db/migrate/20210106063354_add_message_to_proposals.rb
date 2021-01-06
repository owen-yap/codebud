class AddMessageToProposals < ActiveRecord::Migration[6.0]
  def change
    add_column :proposals, :message, :text
  end
end
