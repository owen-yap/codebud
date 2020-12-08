class Proposal < ApplicationRecord
  belongs_to :question
  has_one :order
end
