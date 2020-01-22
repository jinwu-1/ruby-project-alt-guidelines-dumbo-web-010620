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
        puts "Welcome to CityRide!".center(100)
    end


    def enter_name
        puts "Please enter your name."
        @user_name = gets.chomp.downcase.capitalize
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
        if user_valid?
            @user = User.find_by(name: @user_name)
            puts "You are logged in."
            main_menu
        else
            puts "Please create an account in our app."
            main_menu
        end
    end


    def create_user
        if user_valid?
            puts "You already have an account."
            main_menu
        else
            @user = User.create(name: @user_name)
            puts "Account have been created."
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


    def check_appointment
        if appointment_valid?
            pp Appointment.where(user_id: @user.id)
            appointment_menu
        else
            puts "Please create an appointment."
            appointment_menu
        end
    end

    
    def display_appointments
        pp Appointment.where(user_id: @user.id)
    end


    def create_appointment
        puts "Please enter date of appointment in MM/DD/YYYY format."
        date = gets.chomp
        puts "Please enter time of appointment. ex: 2:35PM"
        time = gets.chomp
        puts "Please select an location"
        location_selector
        puts "Please select a bike from the list and enter the ID of the bike. ex: 58"
        bike_id = gets.chomp
        
        Appointment.create(date: date, time: time, user_id: @user.id, bike_id: bike_id)
        puts "Appointment have been created." # Interpolate the string ***
        appointment_menu
    end


    def location_selector
        prompt = TTY::Prompt.new
        prompt.select("Select location of bike") do |menu|
            menu.choice "Bronx", -> {pp Bike.where(location: "Bronx")}
            menu.choice "Queens", -> {pp Bike.where(location: "Queens")}
            menu.choice "Brooklyn", -> {pp Bike.where(location: "Brooklyn")}
            menu.choice "Manhattan", -> {pp Bike.where(location: "Manhattan")}
            menu.choice "Staten Island", -> {pp Bike.where(location: "Staten Island")}
        end
    end


    def update_appointment
        display_appointments
        puts "Please enter the ID of the appointment you want to update."
        id = gets.chomp
        puts "Please enter new date of appointment in MM/DD/YYYY format."
        date = gets.chomp
        puts "Please enter new time of the appointment. ex: 3:45PM"
        time = gets.chomp

        Appointment.find(id).update(date: date)
        Appointment.find(id).update(time: time)
        
        puts "Your appointment have been updated"
        Appointment.find(id)
        display_appointments
        appointment_menu
    end

    
    def delete_appointment
        check_appointment
        puts "Please enter the ID of the appointment you want to delete."
        id = gets.chomp
        Appointment.find(id).destroy
        puts "Your appointment have been deleted."
        appointment_menu
    end


    def delete_all_appointments
        Appointment.where(user_id: @user.id).destroy_all
        puts "Your appointments have been deleted."
        appointment_menu
    end


#Bikes

    def bike_by_location
        prompt = TTY::Prompt.new
        prompt.select("Select location of bike") do |menu|
            menu.choice "Bronx", -> {pp Bike.where(location: "Bronx")}
            menu.choice "Queens", -> {pp Bike.where(location: "Queens")}
            menu.choice "Brooklyn", -> {pp Bike.where(location: "Brooklyn")}
            menu.choice "Manhattan", -> {pp Bike.where(location: "Manhattan")}
            menu.choice "Staten Island", -> {pp Bike.where(location: "Staten Island")}
        end
        bike_menu
    end


# CLI Menus

    def main_menu
        prompt = TTY::Prompt.new

        welcome
        puts "Hello #{@user_name.capitalize}!"
        prompt.select("Kindly ignore default message") do |menu|
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
            menu.choice "exit", -> {main_menu}
        end

    end


    def bike_menu
        prompt = TTY::Prompt.new

        welcome
        puts "Hello #{@user_name.capitalize}!"
        prompt.select("What would you like to do today?") do |menu|
            menu.choice "bike by location", -> {bike_by_location}
            menu.choice "exit", -> {main_menu}
        end

    end

   
    def clear
        system ("clear")
    end


end
