class CreateBios < ActiveRecord::Migration[6.0]
  def change
    create_table :bios do |t|
      t.text :content

      t.timestamps
    end
  end
end
