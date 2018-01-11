class CreateAppointments < ActiveRecord::Migration[5.1]
  def change
    create_table :appointments do |t|
      t.string :participant
      t.datetime :start_date
      t.datetime :end_date
      t.integer :duration

      t.timestamps
    end
  end
end
