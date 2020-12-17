class RemoveMaxPriceFromQuestions < ActiveRecord::Migration[6.0]
  def change
    remove_column :questions, :max_price, :integer
  end
end
