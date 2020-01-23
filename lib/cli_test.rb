require "tty-prompt"
class Test

    def loop_print(appointment)
        puts "ID: #{appointment.id}"
        puts "Date: #{appointment.date}"
        puts "Time: #{appointment.time}"
    end
end