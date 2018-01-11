# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

start_period = Time.now.utc.change(min: 0)
10.times do |i|
  start_date = start_period.advance(hour: i)
  end_date = start_date.advance(minutes: [15, 30, 45].sample)
  Appointment.create!(participant: "Visitor ##{i}", start_date: start_date, end_date: end_date)
end
