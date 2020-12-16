class Order < ApplicationRecord
  belongs_to :proposal
  has_one :review
  has_one :payment

  monetize :price_cents
end
