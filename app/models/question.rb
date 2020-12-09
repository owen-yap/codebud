class Question < ApplicationRecord
  belongs_to :user
  has_many :requirements, dependent: :destroy
  has_many :skills, through: :requirements

  validates :start_time, :end_time, presence: true
  validate :end_time_after_start_time

  private

  def end_time_after_start_time
    return if end_time.blank? || start_time.blank?

    if end_time < start_time
      errors.add(:end_time, "must be after the start time")
    end

   end
end
