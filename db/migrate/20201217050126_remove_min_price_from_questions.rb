class RemoveMinPriceFromQuestions < ActiveRecord::Migration[6.0]
  def change
    remove_column :questions, :min_price, :integer
  end
end
