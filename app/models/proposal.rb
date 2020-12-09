class Proposal < ApplicationRecord
  belongs_to :question
  belongs_to :user
  has_one :order
end
