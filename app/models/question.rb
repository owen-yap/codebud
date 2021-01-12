class Question < ApplicationRecord
  belongs_to :user
  has_many :requirements, dependent: :destroy
  has_many :skills, through: :requirements
  has_many :proposals, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_rich_text :rich_body

  validates :title, presence: true
  validates :status, inclusion: { in: ["pending", "in progress", "answered"] }

  include PgSearch::Model
  pg_search_scope :global_search, against: %i[title description], associated_against: {
    skills: :name
  }, using: {
    tsearch: { prefix: true }
  }

  def selected_proposal
    return proposals.find_by status: ["selected", "completed"]
  end

  def applied_by?(given_user)
    proposals.where(user: given_user).exists?
  end
end
