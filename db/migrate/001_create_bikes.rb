class CreateBikes < ActiveRecord::Migration[5.1]
    def change
        create_table :bikes do |t|
            t.string :color
            t.string :location
            t.float :price

            t.timestamps
        end
    end
end