class Order < ApplicationRecord
  has_one :review, dependent: :destroy
  has_one :payment, dependent: :destroy
  belongs_to :proposal
  monetize :price_cents

  validates :status, inclusion: { in: %w[pending paid completed] }

  def payer
    proposal.question.user
  end

  def payee
    proposal.user
  end

  def completed?
    status == "completed"
  end
end
