class Review < ApplicationRecord
  belongs_to :order
  belongs_to :user

  def student
    order.proposal.question.user
  end
end
