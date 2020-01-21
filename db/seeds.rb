User.destroy_all
Bike.destroy_all
Appointment.destroy_all

10.times do
User.create(name: Faker::Name.first_name)
Bike.create(color: Faker::Color.color_name, location: Faker::Address.city, price: Faker::Commerce.price)
Appointment.create(time: Faker::Time.forward(days: 14,  period: :evening, format: :long), user_id: User.all.sample.id, bike_id: Bike.all.sample.id)
end