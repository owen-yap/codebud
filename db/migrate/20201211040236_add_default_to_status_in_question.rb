class AddDefaultToStatusInQuestion < ActiveRecord::Migration[6.0]
  def change
    change_column :questions, :status, :string, default: "pending"
  end
end
