class Question < ApplicationRecord
  belongs_to :user
  has_many :requirements
  has_many :skills, through: :requirements
end
