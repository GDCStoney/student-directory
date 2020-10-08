=begin
  object listing:
    School, Student (Future - user?)
    CmdBuilding - to manage user input
    Screen? - do we need a class for the screen interface

=end

class Student
  attr_accessor :name, :cohort, :id


  def initialize(name_prefix, name_first, name_family, name_middle)
    @name_prefix = name_prefix
    @name_first = name_first
    @name_family = name_family
    @name_middle = name_middle
    @name = @name_prefix + " " + @name_first + " " + @name_middle + " " + @name_family
  end
end

class School
  attr_accessor :name, :location, :id

  def initialize(name, location)
    @name = name
    @location = location
  end
end

class User # place holder at the moment ... MIGHT want to implement later
end

class CmdCreator
  # take the character inputs ... and work towards building a "command"
  # for the responding methods
  require 'io/console'
  attr_reader :output_command

  @@command_history = []

  def initialize(commands, location)
    @commands_valid = commands

    input_char = STDIN.getch
    output_command = ""

    while input_char != "\r"
      if input_char == "\u007F"
        output_command = output_command[0..-2]
        print "\033[1D\033[K"
      elsif !((/[a-z\s]/ =~ input_char) == nil)
        output_command += input_char
        print input_char

        @commands_valid[location].each do |command|
          if command[0..output_command.length-1] == output_command
            print "\033[100D\033[K#{command}"
            output_command = command
            break
          end
        end
      end

      input_char = STDIN.getch
    end
    print "\n"

    @@command_history << {:date => Time.now.strftime("%Y-%m-%d %H:%M"), :location => location, :command => output_command}

    if @commands_valid[location].include? output_command
      @output_command = output_command
    else
      @output_command = false
    end
  end

  def self.command_history
    @@command_history
  end
end

# how to manage the visual interface - another class / or methods?
def kernel
  # best practice to form App variables in the kernel or @@ class variables
  # at the 'root'???
  menu_commands = {
    :main => ["manage students", "reports", "exit directory"],
    :reports => ["student listing", "first letter", "cohort listing", "quit reports"],
    :students => ["create list", "add student", "delete student", "quit student management"]
  }

  puts "Welcome - what would you like to do?"
  input_command = CmdCreator.new(menu_commands, :main).output_command

  input_command = CmdCreator.new(menu_commands, :reports).output_command

  puts CmdCreator.command_history.inspect
end

kernel
