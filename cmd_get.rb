
class Cmd_get
  require 'io/console'
  attr_reader :output_command

  @@command_history=[]

  def self.command_history
    @@command_history
  end

  def initialize
  end

  def command_get(valid_commands)
    @commands_valid = valid_commands

    command_output = ""
    tab_commands = []
    del_previous = false

    input_char = STDIN.getch

    while input_char != "\r"
      if input_char == "\u007F"
        if del_previous
          del_previous = false
          command_output = ""
          print "\033[100D\033[K"
        else
          del_previous = true
          command_output = command_output[0..-2]
          tab_commands=[]
          print "\033[1D\033[K"
        end
      else
        del_previous = false
        if input_char =="\t"
          if tab_commands.length > 1
            tab_commands.rotate!
            print "\033[100D\033[K#{tab_commands[0]}"
            command_output = tab_commands[0]
          else
            tab_commands =  @commands_valid.select { |command|
              command[0..command_output.length-1] == command_output
            }
            if tab_commands.length >= 1
              print "\033[100D\033[K#{tab_commands[0]}"
              command_output = tab_commands[0]
            end
          end
        elsif !((/[a-z\s]/ =~ input_char) == nil)
          command_output += input_char
          print input_char
        end
      end

      input_char = STDIN.getch
    end
    print "\n"

    @@command_history << {:date => Time.now.strftime("%Y-%m-%d %H:%M:%S"),
        :command => command_output}

    if @commands_valid.include? command_output
      @output_command = command_output
    else
      @output_command = false
    end
  end
end

def kernel
  commands_all = {
    :main => ["manage students", "manage users", "reports", "exit directory"],
    :reports => ["student listing", "first letter", "cohort listing", "quit reports"],
    :students => ["create list", "add student", "delete student", "quit student management"]
  }
  cmd_manager = Cmd_get.new

  location = :main
  puts "\nenter selection for #{location.to_s.capitalize}"
  input_command = cmd_manager.command_get(commands_all[location])

  location = :reports
  puts "\nenter selection for #{location.to_s.capitalize}"
  input_command = cmd_manager.command_get(commands_all[location])

  puts "\n#{Cmd_get.command_history.inspect}\n\n"
end

kernel
