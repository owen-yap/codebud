class Question < ApplicationRecord
  belongs_to :user
  has_many :requirements
  has_many :skills, through: :requirements

  validates :start_time, :end_time, :title, :description, :min_price, :max_price, presence: true
  validate :end_time_after_start_time

  private

  def end_time_after_start_time
    return if end_time.blank? || start_time.blank?

    errors.add(:end_time, "must be after the start time") if end_time < start_time
  end
end
