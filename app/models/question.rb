class Question < ApplicationRecord
  belongs_to :user
  has_many :requirements, dependent: :destroy
  has_many :skills, through: :requirements
  has_many :proposals, dependent: :destroy

  validates :start_time, :end_time, :title, :description, :min_price, :max_price, presence: true
  validate :end_time_after_start_time

  include PgSearch::Model
  pg_search_scope :global_search, against: %i[title description], associated_against: {
    skills: :name
  }, using: {
    tsearch: { prefix: true }
  }

  def selected_proposal
    return proposals.find_by status: "selected"
  end

  private

  def end_time_after_start_time
    return if end_time.blank? || start_time.blank?

    errors.add(:end_time, "must be after the start time") if end_time < start_time
  end
end
