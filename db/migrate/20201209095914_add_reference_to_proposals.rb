class AddReferenceToProposals < ActiveRecord::Migration[6.0]
  def change
    add_reference :proposals, :user, foreign_key: true
  end
end
