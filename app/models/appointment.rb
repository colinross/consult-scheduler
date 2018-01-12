# An appointment is a specific time (and duration) linked with a particular
# participant that allows for providers to have an ordered, structured list
# of events, such as video-based virtual consultations.
class Appointment < ApplicationRecord
  enum duration: [15, 30, 45, 60] # Minutes

  after_initialize :init
  # Validations
  validates_presence_of :participant, :duration
  validates_presence_of :start_date, :end_date

  # Checks if a given appointment overlaps with this one
  def overlaps?(other)
    start_date <= other.end_date && other.start_date <= end_date
  end

  private

  # after initialization hook
  def init
    self.end_date ||= default_end_date
    self.duration ||= ((end_date - start_date) / 60).to_i if (start_date.present? && end_date.present?) && duration.blank?
  end

  # calculate the default end_date given a start_date and duration are available
  def default_end_date
    return nil unless start_date && duration
    start_date.advance(minutes: duration.to_i)
  end
end
