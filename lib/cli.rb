require "tty-prompt"
require "pry"

class CLI
    
    attr_reader :user_name

    def run
        clear
        welcome
        enter_name
        binding.pry
        clear
        menu
    end


    def welcome
        puts "Welcome to CityRide!".center(100)
    end


    def enter_name
        puts "Please enter your name."
        @user_name = gets.chomp.downcase.capitalize
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

    
    def create_appointment
        "Please enter date of appointment in MM/DD/YYYY format."
        date = gets.chomp
        "Please enter time of appointment. ex: 2:35PM"
        time = gets.chomp
        "Please select an location"
        
        "Please select a bike"
        
        # Appointment.create(date: date, time: time, user_id: @user_name.id, bike_id: 1)
    end


    def check_appointment
        Appointment.where(user_id: @user.id)
    end


    def delete_all_appointment
        check_appointments.delete_all
    end


    def menu
        prompt = TTY::Prompt.new

        welcome
        puts "Hello #{@user_name.capitalize}!"
        prompt.select("What would you like to do today?") do |menu|
            menu.choice "make an appointment"
            menu.choice "check an appointment"
            menu.choice "update an appointment"
            menu.choice "delete an appointment"
        end

    end

   
    def clear
        system ("clear")
    end


end
