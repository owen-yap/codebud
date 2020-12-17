class UserSkill < ApplicationRecord
  belongs_to :user
  belongs_to :skill, dependent: :destroy
end
