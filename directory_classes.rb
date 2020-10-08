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

  @@command_history=[]

  def self.command_history
    @@command_history
  end

  def initialize

  end

  def command_get(menu_to_use,print_initial = true)
    @commands_valid = menu_to_use.commands_valid
    @location = menu_to_use.location

    command_output = ""
    tab_commands = []

    puts "\n" # this is to provide room for the 'help' function if needed

    if print_initial # see if initial menu needs to be printed before input
      input_char = "?"
    else
      input_char = STDIN.getch
    end

    while input_char != "\r"
      if input_char == "\u007F"
        command_output = command_output[0..-2]
        print "\033[1D\033[K"
      elsif input_char =="\t"
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
      elsif input_char == "?"
        puts "\033[1A\t#{@commands_valid.join(", ")}"
        print command_output
      elsif !((/[a-z\s]/ =~ input_char) == nil)
        command_output += input_char
        print input_char
      end

      input_char = STDIN.getch
    end
    print "\n"

    @@command_history << {:date => Time.now.strftime("%Y-%m-%d %H:%M:%S"),
        :location => menu_to_use.location, :command => command_output}

    if @commands_valid.include? command_output
      @output_command = command_output
    else
      @output_command = false
    end
  end
end

class Interactive_menu
  attr_reader :commands_all, :commands_valid
  attr_accessor :location

  @@commands_all = {
    :main => ["manage students", "manage users", "reports", "exit directory"],
    :reports => ["student listing", "first letter", "cohort listing", "quit reports"],
    :students => ["create list", "add student", "delete student", "quit student management"]
  }

  def initialize
    @location = :main
  end

  def print # for 'help' function
  end

  def commands_valid
    @@commands_all[@location]
  end
end

# how to manage the visual interface - another class / or methods?
def kernel
  # best practice to form App variables in the kernel or @@ class variables
  # at the 'root'???
  main_menu = Interactive_menu.new
  command_checker = CmdCreator.new

  puts "#{main_menu.location.upcase}: - what would you like to do?"
  input_command = command_checker.command_get(main_menu)

  main_menu.location = :reports
  puts "#{main_menu.location.upcase}:- what would you like to do?"
  input_command = command_checker.command_get(main_menu, false)

  puts "\n#{CmdCreator.command_history.inspect}\n\n"
end

kernel
