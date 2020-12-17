class AddBudgetToQuestions < ActiveRecord::Migration[6.0]
  def change
    add_column :questions, :budget, :integer
  end
end
