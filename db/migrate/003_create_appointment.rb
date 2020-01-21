class CreateAppointment < ActiveRecord::Migration[5.1]
    def change
        create_table :appointments do |t|
            t.string :time
            t.integer :user_id
            t.integer :bike_id

            t.timestamps
        end
    end
end
