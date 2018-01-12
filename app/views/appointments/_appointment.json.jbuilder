json.id appointment.id
json.type 'appointments'
json.attributes do
  json.extract! appointment, :created_at, :updated_at
  json.extract! appointment, :participant, :duration
  json.start_date appointment.start_date.iso8601
  json.end_date appointment.end_date.iso8601
end
json.links do
  json.self appointment_url(appointment, format: :json)
end
