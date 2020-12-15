class Review < ApplicationRecord
  belongs_to :order

  def student
    order.proposal.question.user
  end
end
