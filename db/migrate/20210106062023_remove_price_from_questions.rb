class RemovePriceFromQuestions < ActiveRecord::Migration[6.0]
  def change
    remove_column :questions, :price_cents, :string
    remove_column :questions, :budget, :string
  end
end
