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
end

class User # place holder at the moment ... MIGHT want to implement later
end

class CmdCreator
  # take the character inputs ... and work towards building a "command"
  # for the responding methods
  require 'io/console'
  attr_reader :input_command

  def initialize(location)
    @commands_valid ={
      :main => ["manage students", "reports", "exit directory"],
      :reports => ["student listing", "first letter", "cohort listing", "quit reports"],
      :students => ["create list", "add student", "delete student", "quit student management"]
    }

    input_char = STDIN.getch
    input_command = ""

    while input_char != "\r"
      if input_char == "\u007F"
        input_command = input_command[0..-2]
        print "\033[1D\033[K"
      elsif !((/[a-z\s]/ =~ input_char) == nil)
        input_command += input_char
        print input_char

        @commands_valid[location].each do |command|
          if command[0..input_command.length-1] == input_command
            print "\033[100D\033[K#{command}"
            input_command = command
            break
          end
        end

      end


      input_char = STDIN.getch
    end

    if @commands_valid[location].include? input_command
      @input_command = input_command
    else
      @input_command = false
    end
  end
end

# how to manage the visual interface - another class / or methods?
def kernel
  puts "Welcome - what would you like to do?"
  input_command = CmdCreator.new(:main).input_command
  puts "\n#{input_command}"
end

kernel
