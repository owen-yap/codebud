class CreateProposals < ActiveRecord::Migration[6.0]
  def change
    create_table :proposals do |t|
      t.integer :price
      t.string :status
      t.datetime :meeting_time
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
