class Requirement < ApplicationRecord
  belongs_to :question
  belongs_to :skill
end
