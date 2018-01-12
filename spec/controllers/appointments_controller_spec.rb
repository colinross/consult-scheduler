require 'rails_helper'

RSpec.describe AppointmentsController, type: :controller do
  let(:valid_attributes) do
    { participant: 'Visitor',
      start_date: Time.now.utc.change(min: 0),
      end_date: Time.now.utc.change(min: 45) }
  end

  let(:invalid_attributes) do
    {  participant: '',
       start_date: Time.now.utc.change(min: 0),
       end_date: Time.now.utc.change(min: 45) }
  end

  describe 'GET #index' do
    before do
      Appointment.create! valid_attributes
    end
    it 'returns a success response' do
      get :index, params: {}, format: 'application/json'
      expect(response).to be_success
    end
  end

  describe 'GET #show' do
    let!(:appointment) { Appointment.create! valid_attributes }
    it 'returns a success response' do
      get :show, params: { id: appointment.to_param }, format: 'application/json'
      expect(response).to be_success
    end
  end

  # TODO: Pending Implmentation
  xdescribe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Appointment' do
        expect do
          post :create, params: { appointment: valid_attributes }, format: 'application/json'
        end.to change(Appointment, :count).by(1)
      end

      it 'renders a JSON response with the new appointment' do
        post :create, params: { appointment: valid_attributes }, format: 'application/json'
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(appointment_url(Appointment.last))
      end
    end

    context 'with invalid params' do
      it 'renders a JSON response with errors for the new appointment' do
        post :create, params: { appointment: invalid_attributes }, format: 'application/json'
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

end
