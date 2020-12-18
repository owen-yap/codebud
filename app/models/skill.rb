class Skill < ApplicationRecord
  has_many :user_skills, dependent: :destroy
  has_many :users, through: :user_skills, dependent: :destroy
  has_many :requirements, dependent: :destroy

  def skill_in_current_user
    id
  end
end
