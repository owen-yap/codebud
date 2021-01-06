class ChangeMessageInProposals < ActiveRecord::Migration[6.0]
  def change
    change_column :proposals, :message, :text, default: ""
  end
end
