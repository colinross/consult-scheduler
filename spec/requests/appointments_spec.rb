require 'rails_helper'

RSpec.describe 'Appointments', type: :request do
  let(:json) { JSON.parse(response.body).with_indifferent_access }

  describe 'GET /appointments [Index]' do
    let!(:appointments) do
      # TODO: We should move to using factory_bot for this test setup
      start_period = Time.now.utc.change(min: 0)
      apts = []
      3.times do |i|
        start_date = start_period.advance(hour: i)
        end_date = start_date.advance(minutes: [15, 30, 45].sample)
        apts << Appointment.create!(participant: "Visitor ##{i}",
                            start_date: start_date,
                            end_date: end_date)
      end
      apts
    end
    it 'returns success' do
      get appointments_path(format: :json)
      expect(response).to have_http_status(200)
    end
    it 'includes all the persisted appointments' do
      get appointments_path(format: :json)
      expect(json[:data].collect{ |l| l[:attributes][:participant] }.uniq).to eq Appointment.pluck(:participant).uniq
    end
  end

  describe 'GET /appointment/:id [show]' do
    let!(:record) { Appointment.create!(participant: 'Elmer Fudd', start_date: Time.now.utc.change(min: 0), duration: 60).reload }
    fit 'includes all the details (JSON-API format)' do
      get appointment_path(id: record.id, format: :json)
      expect(json[:data][:id]).to eq record.id
      expect(json[:data][:type]).to eq 'appointments'
      expect(json[:data][:attributes][:participant]).to eq record.participant
      expect(json[:data][:attributes][:start_date]).to eq record.start_date.iso8601
      expect(json[:data][:attributes][:end_date]).to eq record.end_date.iso8601
      expect(json[:data][:attributes][:duration]).to eq record.duration
    end
  end
end
