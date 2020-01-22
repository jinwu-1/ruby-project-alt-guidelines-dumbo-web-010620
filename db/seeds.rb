User.destroy_all
Bike.destroy_all
Appointment.destroy_all
 
5.times do
User.create(name: Faker::Name.first_name)
end

colors = ["Blue", "Red", "Yellow", "Green", "White", "Black"]

5.times do
Bike.create(color: colors.sample, location: "Brooklyn", price: Faker::Commerce.price(range: 3..6.5))
Bike.create(color: colors.sample, location: "Manhattan", price: Faker::Commerce.price(range: 7..10.0))
Bike.create(color: colors.sample, location: "Bronx", price: Faker::Commerce.price(range: 3..6.5))
Bike.create(color: colors.sample, location: "Queens", price: Faker::Commerce.price(range: 3..6.5))
Bike.create(color: colors.sample, location: "Staten Island", price: Faker::Commerce.price(range: 2.5..6.0))
end

Appointment.create(date: "01/23/2020" , time: "12:00PM" , user_id: User.all.sample.id, bike_id: Bike.all.sample.id)
Appointment.create(date: "01/26/2020" , time: "2:00PM" , user_id: User.all.sample.id, bike_id: Bike.all.sample.id)
Appointment.create(date: "01/27/2020" , time: "3:00PM" , user_id: User.all.sample.id, bike_id: Bike.all.sample.id)
Appointment.create(date: "01/24/2020" , time: "3:40PM" , user_id: User.all.sample.id, bike_id: Bike.all.sample.id)
Appointment.create(date: "01/27/2020" , time: "2:15PM" , user_id: User.all.sample.id, bike_id: Bike.all.sample.id)
Appointment.create(date: "01/28/2020" , time: "1:45PM" , user_id: User.all.sample.id, bike_id: Bike.all.sample.id)
Appointment.create(date: "01/23/2020" , time: "12:00PM" , user_id: User.all.sample.id, bike_id: Bike.all.sample.id)
