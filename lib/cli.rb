class CLI

    attr_reader :user_name

    def run
        welcome
        enter_name
    end

    def welcome
        puts "Welcome to NationRide!"
    end

    def enter_name
        puts "Please enter your name."
        @user_name = gets.chomp
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
            User.all.find_by(name: @user_name)
        else
            User.create(name: @user_name)
        end
    end

    def appointment_valid?
        if Appointment.all.find_by(user_id: find_user.id)
            true
        else
            false
        end
    end

    def find_appointment
        if appointment_valid?
            find_user.appointments
        else
            puts "Would you like to create an appointment? Y/N"
                answer = gets.chomp
                if Y 
                "Please enter date in MM/DD/YYYY format"
                date = gets.chomp
                "Please enter time for your appointment (12-hour format)"
                time = gets.chomp
                "Pick bike color"
                list of bikes/color
                else 
                "Thank you have a nice day"
                end
            Appointment.create(time: "1021",user_id: find_user.id, bike_id: 1 )
        end
    end



end
