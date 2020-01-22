require "tty-prompt"
require "pry"

class CLI
    
    attr_reader :user_name

    def run
        clear
        welcome
        enter_name
        find_user
        clear
        menu
        
    
    end

    def welcome
        puts "Welcome to NationRide!".center(100)
    end

    def enter_name
        puts "Please enter your name."
        @user_name = gets.chomp.downcase
    end


    def user_valid?
        if User.all.find_by(name: @user_name)
            true
        else
            false
        end
    end

    def find_user
        if user_valid?
            # @user_inst =
             User.all.find_by(name: @user_name) 
        else
            User.create(name: @user_name)
        end
    end
    

    def appointment_valid?
        if Appointment.where("user = ?", @user_name)
            true
            binding.pry
        else
            false
        end
    end

    def find_appointment
        if appointment_valid?
            desired_appointment = Appointment.find_by(user: @user_name)
            puts "The appointment for blah"
        else
            puts "You have no appointments. Would you like to make one?"
        #     puts "Would you like to create an appointment? Y/N"
        #         answer = gets.chomp
        #         if Y 
        #         "Please enter date in MM/DD/YYYY format"
        #         date = gets.chomp
        #         "Please enter time for your appointment (12-hour format)"
        #         time = gets.chomp
        #         "Pick bike color"
        #         list of bikes/color
        #         else 
        #         "Thank you have a nice day"
        #         end
        #     Appointment.create(time: "1021",user_id: find_user.id, bike_id: 1 )
        end
    end

    def menu
        prompt = TTY::Prompt.new

        welcome
        puts "Hello #{@user_name.capitalize}!"
        prompt.select("What would you like to do today?") do |menu|
            menu.choice "make an appointment"
            menu.choice "check an appointment", -> {find_appointment}
            menu.choice "update an appointment"
            menu.choice "delete an appointment"
        end

    end

   
    def clear
        system ("clear")
    end


end
