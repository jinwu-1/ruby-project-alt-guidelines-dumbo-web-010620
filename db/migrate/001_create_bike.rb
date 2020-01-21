class CreateBike < ActiveRecord::Migration[5.1]
    def change
        create_table :bikes do |t|
            t.string :color
            t.string :location
            t.integer :price

            t.timestamps
        end
    end
end
