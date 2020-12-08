class Skill < ApplicationRecord
  belongs_to :user_skill
  has_many :requirements
  #stupid commment
end
