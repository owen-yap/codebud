class UserSkill < ApplicationRecord
  belongs_to :user
  has_many :skills
end
