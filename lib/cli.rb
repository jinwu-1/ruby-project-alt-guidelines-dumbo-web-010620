require "tty-prompt"
require "pry"
require "pp"

class CLI
    
    attr_reader :user_name, :user
    attr_accessor :appointments

    def run
        clear
        welcome
        enter_name
        clear
        menu
    end


    def welcome
        puts "Welcome to CityRide!".center(100)
    end


    def enter_name
        puts "Please enter your name."
        @user_name = gets.chomp.downcase.capitalize
        check_user
    end


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
        else
            puts "Please create an account in our app."
        end
    end


    def create_user
        @user = User.create(name: @user_name)
    end

    
    def appointment_valid?
        if Appointment.find_by(user_id: @user.id)
            true
        else
            false
        end
    end


    def check_appointment
        if appointment_valid?
            @appointments = Appointment.where(user_id: @user.id)
        else
            puts "Please create an appointment."
        end
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
    end


    def location_selector
        prompt = TTY::Prompt.new
        prompt.select("Select location of bike") do |menu|
            menu.choice "Bronx", -> {pp @array = Bike.where(location: "Bronx")}
            menu.choice "Queens", -> {pp @array = Bike.where(location: "Queens")}
            menu.choice "Brooklyn", -> {pp @array = Bike.where(location: "Brooklyn")}
            menu.choice "Manhattan", -> {pp @array = Bike.where(location: "Manhattan")}
            menu.choice "Staten Island", -> {pp @array = Bike.where(location: "Staten Island")}
        end
    end


    def delete_all_appointment
        check_appointments.delete_all
    end


    def menu
        prompt = TTY::Prompt.new

        welcome
        puts "Hello #{@user_name.capitalize}!"
        prompt.select("What would you like to do today?") do |menu|
            menu.choice "make an appointment", -> {pp create_appointment}
            menu.choice "check an appointment", -> {pp check_appointment}
            menu.choice "update an appointment", -> {}
            menu.choice "delete an appointment", -> {delete_all_appointment}
            menu.choice "exit"
        end

    end

   
    def clear
        system ("clear")
    end


end
