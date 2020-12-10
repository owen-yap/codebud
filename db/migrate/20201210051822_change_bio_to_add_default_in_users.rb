class ChangeBioToAddDefaultInUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :bios, :content, :text, default: ""
  end
end
