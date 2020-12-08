class CreateQuestions < ActiveRecord::Migration[6.0]
  def change
    create_table :questions do |t|
      t.string :title
      t.string :description
      t.integer :min_price
      t.integer :max_price
      t.datetime :start_time
      t.datetime :end_time
      
      t.references :user, null: false, foreign_key: true
      
      t.timestamps
    end
  end
end
