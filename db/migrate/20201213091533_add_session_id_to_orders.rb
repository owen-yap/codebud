class AddSessionIdToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :session_id, :string
  end
end
