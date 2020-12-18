class Review < ApplicationRecord
  belongs_to :order
  belongs_to :user

  def student
    order.proposal.question.user
  end

  def full_stars
    rating = 0 if rating.nil?
    rating.floor
  end

  def half_stars
    (rating - full_stars).ceil unless rating.nil?
  end

  def empty_stars
    5 - (full_stars + half_stars)
  end
end
