require 'rails_helper'

RSpec.describe Appointment, type: :model do
  let(:start_date) { Time.zone.local(2017, 12, 24, 01, 00, 00) } # Sun, 24 Dec 2017 01:00:00 UTC +00:00
  let(:end_date) { Time.zone.local(2017, 12, 24, 02, 00, 00) } # Sun, 24 Dec 2017 02:00:00 UTC +00:00

  # Attributes
  it { is_expected.to validate_presence_of(:participant) }
  it { is_expected.to validate_presence_of(:duration) }
  it { is_expected.to define_enum_for(:duration).with([15, 30, 45, 60]) }

  context 'default values' do
    it 'initializes end_date based on duration' do
      appointment = described_class.new(start_date: start_date, duration: 60 )
      expect(appointment.end_date).to eq end_date
    end
  end

  describe :overlaps? do
    subject(:appointment) { Appointment.new(start_date: start_date, duration: 60 ) }
    let(:overlapping_appointment) { Appointment.new(start_date: start_date + 15.minutes, end_date: end_date + 15.minutes) }
    let(:non_overlapping_appointment) { Appointment.new(start_date: start_date + 3.hours, end_date: end_date + 3.hours ) }

    it { expect(subject.overlaps?(overlapping_appointment)).to be true }
    it { expect(subject.overlaps?(non_overlapping_appointment)).to be false }
  end
end

