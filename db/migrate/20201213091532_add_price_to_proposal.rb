class AddPriceToProposal < ActiveRecord::Migration[6.0]
  def change
    add_monetize :proposals, :price, currency: { present: false }
    add_monetize :questions, :price, currency: { present: false }
    add_monetize :orders, :price, currency: { present: false }
  end
end
