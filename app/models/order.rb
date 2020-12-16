class Order < ApplicationRecord
  belongs_to :proposal
  has_one :review, dependent: :destroy
  has_one :payment
  monetize :price_cents

  validates :status, inclusion: { in: %w[pending completed] }
  def payer
    proposal.question.user
  end

  def payee
    proposal.user
  end
end
