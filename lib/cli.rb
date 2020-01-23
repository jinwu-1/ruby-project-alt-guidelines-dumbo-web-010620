require "tty-prompt"
require "pry"
require "pp"

class CLI
    
    attr_reader :user_name, :user

    def run
        clear
        welcome
        enter_name
        clear
        main_menu
    end

    def welcome
        puts "Welcome to CityRide".center(100)
    end

    def enter_name
        puts "Please enter your name"
        @user_name = gets.gsub(/[^0-9a-z]/i, '').downcase.capitalize
        if @user_name.length > 0
            true
        else
            enter_name
        end
    end

# Users

    def user_valid?
        if User.find_by(name: @user_name)
            true
        else
            false
        end
    end

    def check_user
        clear
        if user_valid?
            @user = User.find_by(name: @user_name)
            puts "-----------------------------------------"
            puts "Logged in successfully"
            puts "-----------------------------------------"
            main_menu
        else
            puts "-----------------------------------------"
            puts "Please create an account in our app"
            puts "-----------------------------------------"
            main_menu
        end
    end

    def create_user
        clear
        if user_valid?
            puts "-----------------------------------------"
            puts "You already have an account"
            puts "-----------------------------------------"
            main_menu
        else
            @user = User.create(name: @user_name)
            puts "-----------------------------------------"
            puts "Account have been created"
            puts "-----------------------------------------"
            main_menu
        end
    end

# Appointments
    
    def appointment_valid?
        if Appointment.find_by(user_id: @user.id)
            true
        else
            false
        end
    end

    def print_appointment
        app = Appointment.all.select {|i|i.user_id == @user.id}
        puts "-----------------------------------------"
        puts "See below for your upcoming appointments"
        puts "-----------------------------------------"
        app.map do |i|
            puts "ID: #{i.id}"
            puts "Date: #{i.date}"
            puts "Time: #{i.time}"
            bike = Bike.find(i.bike_id)
            puts "Location: #{bike.location}"
            puts "-----------------------------------------"
        end
    end

    def check_appointment
        clear
        if appointment_valid?
            print_appointment
            appointment_menu
        else
            puts "-----------------------------------------"
            puts "Please create an appointment"
            puts "-----------------------------------------"
            appointment_menu
        end
    end

    def create_appointment
        clear
        puts "Please enter date of appointment in MM/DD/YYYY format."
        date = gets.chomp
        puts "Please enter time of appointment. ex: 2:35PM"
        time = gets.chomp
        puts "Please select an location"
        location_selector
        puts "Please select a bike from the list and enter the ID of the bike. ex: 58"
        bike_id = gets.chomp
        
        Appointment.create(date: date, time: time, user_id: @user.id, bike_id: bike_id)
        clear
        puts "-----------------------------------------"
        puts "The appointment have been created"
        puts "-----------------------------------------"
        appointment_menu
    end

    def location_selector
        prompt = TTY::Prompt.new
        prompt.select("Select location of bike") do |menu|
            menu.choice "Bronx", -> {puts bikes("Bronx")}
            menu.choice "Queens", -> {puts bikes("Queens")}
            menu.choice "Brooklyn", -> {puts bikes("Brooklyn")}
            menu.choice "Manhattan", -> {puts bikes("Manhattan")}
            menu.choice "Staten Island", -> {puts bikes("Staten Island")}
        end
    end

    def update_appointment
        clear
        if print_appointment == []
            puts "-----------------------------------------"
            puts "You have no appointment scheduled"
            puts "-----------------------------------------"
            appointment_menu
        else 
            puts "Please enter the ID of the appointment you want to update."
            id = gets.chomp
            puts "Please enter new date of appointment in MM/DD/YYYY format."
            date = gets.chomp
            puts "Please enter new time of the appointment. ex: 3:45PM"
            time = gets.chomp

            Appointment.find(id).update(date: date)
            Appointment.find(id).update(time: time)

            clear
            puts "-----------------------------------------"
            puts "Your appointment have been updated"
            Appointment.find(id)
            puts print_appointment
            appointment_menu
        end
    end
   
    def delete_appointment
        clear
        if print_appointment == []
            clear
            puts "-----------------------------------------"
            puts "You have no appointment scheduled"
            puts "-----------------------------------------"
            appointment_menu
        else
            puts "Please enter the ID of the appointment you want to delete"
            id = gets.chomp
            Appointment.find(id).destroy
            clear
            puts "-----------------------------------------"
            puts "Your appointment have been deleted"
            puts "-----------------------------------------"
            appointment_menu
        end
    end

    def delete_all_appointments
        clear
        if print_appointment == []
            clear
            puts "-----------------------------------------"
            puts "You have no appointment scheduled"
            puts "-----------------------------------------"
            appointment_menu
        else
            Appointment.where(user_id: @user.id).destroy_all
            clear
            puts "-----------------------------------------"
            puts "Your appointments have been deleted"
            puts "-----------------------------------------"
            appointment_menu
        end
    end

#Bikes

    def bike_by_location
        clear
        prompt = TTY::Prompt.new
        prompt.select("Select location of bike") do |menu|
            menu.choice "Bronx", -> {bikes("Bronx")}
            menu.choice "Queens", -> {bikes("Queens")}
            menu.choice "Brooklyn", -> {bikes("Brooklyn")}
            menu.choice "Manhattan", -> {bikes("Manhattan")}
            menu.choice "Staten Island", -> {bikes("Staten Island")}
        end
        bike_menu
    end

    def bike_location(location) 
       Bike.all.select {|bike|bike.location == location}
    end

    def bikes(location)
        bikes = bike_location(location)
        clear
        puts "-----------------------------------------"
        puts "List of Bikes in #{location}"
        puts "-----------------------------------------"
        bikes.map do |bike|
            puts "ID: #{bike.id}"
            puts "Color: #{bike.color}"
            puts "Location: #{bike.location}"
            puts "Price: $#{bike.price}"
            puts "-----------------------------------------"
        end
    end

# CLI Menus

    def main_menu
        prompt = TTY::Prompt.new
        welcome
        puts "Hello #{@user_name.capitalize}!"
        prompt.select("What would you like to do today?") do |menu|
            menu.choice "login", -> {check_user}
            menu.choice "create account", -> {create_user}
            menu.choice "appointments", -> {appointment_menu}
            menu.choice "bikes", -> {bike_menu}
            menu.choice "exit"
        end
    end

    def appointment_menu
        prompt = TTY::Prompt.new
        welcome
        puts "Hello #{@user_name.capitalize}!"
        prompt.select("What would you like to do today?") do |menu|
            menu.choice "make an appointment", -> {create_appointment}
            menu.choice "check an appointment", -> {check_appointment}
            menu.choice "update an appointment", -> {update_appointment}
            menu.choice "delete an appointment", -> {delete_appointment}
            menu.choice "delete all appointments", -> {delete_all_appointments}
            menu.choice "back", -> {main_menu}
        end
    end

    def bike_menu
        prompt = TTY::Prompt.new
        welcome
        puts "Hello #{@user_name.capitalize}!"
        prompt.select("What would you like to do today?") do |menu|
            menu.choice "bike by location", -> {bike_by_location}
            menu.choice "back", -> {main_menu}
        end
    end
   
    def clear
        system ("clear")
    end

end
