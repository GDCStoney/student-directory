require 'io/console'

def input_students
  puts "Please enter the names of the students"
  puts "to finish, just hit return twice"
  # create an empty array unless first entry is ""
  students =[]
  name = gets.chomp
  # while name is not empty, get details
  while !name.empty? do
    # create student hash in students array
    # id is created with the intent that deletion doesn't delete a record
    id_string = ("000" + students.count.to_s)[-3,3]
    students << {name: name, id: id_string, cohort: :november, status: "active"}

    puts "Now we have #{students.count} students"
    name =gets.chomp
  end
  # return the array of students or empty
  students
end

def print_header
  # print the header for the list of students
  puts "\nThe students of Villains Academy"
  puts "--------------"
end

def print_students(students)
  # print each student name
  max_name_length = 0
  students.each do |student|
    if student[:status] == "active"
      max_name_length = [student[:name].length,  max_name_length].max
    end
  end

  students.each do |student|
    if student[:status] == "active"
      puts "#{student[:id]} - " + student[:name].center(max_name_length) +
          " (#{student[:cohort]} cohort)"
    end
  end
end

def print_footer(names)
  # print the footer for the list of students
  puts "\nOverall, we have #{names.select
      { |student| student[:status] == "active" }.count} great students\n"
end

def report_first_letter(students, report_key)
  puts "\n"
  students.each do |student|
    if student[:status] == "active" && student[:name][0,1].downcase == report_key
      puts "#{student[:id]} - #{student[:name]} (#{student[:cohort]})"
    end
  end
end

def report_short_names(students, report_length)
  puts "\n"
  students.each do |student|
    if student[:name].length <= report_length
      puts "#{student[:id]} - #{student[:name]} (#{student[:cohort]})"
    end
  end
end

def get_user_input (location)
  choices = {
    :main => ["report", "create", "print", "exit"],
    :reports => ["first letter", "short names", "quit"]
  }
  input_full = ''

  case location
  when "main"
    puts "What would you like to do?   '?' for help"
  when "reports"
    puts "Which report would you like to run?   '?' for help"
  end

  input_char = STDIN.getch

  case input_char
  when "?"
    puts "\n'" + choices[location.to_sym].join("', '") + "'"
    input_full = ''
    input_char = ''
  else
    while input_char != "\r"
      if input_char == "\u007F"
        if input_full.length == 1
          input_full = ""
        else
          input_full = input_full[0..input_full.length-2]
        end
        input_char=''
        print "\033[1D\033[K"
      else
        input_full += input_char
        print input_char

        choices[location.to_sym].each  do |choice|
          if input_full == choice[0..input_full.length-1]
            print choice[input_full.length..choice.length]
            input_full = choice
          end
        end
    end

      input_char = STDIN.getch
    end

    print "\n"
  end

  input_full
end

def kernel
  # Setup variables
  students = [
    {name: 'Dr. Hannibal Lecter', id: "001", cohort: :november, status: "active"},
    {name: "Darth Vader", id: "002", cohort: :november, status: "active"},
    {name: "Nurse Ratched", id: "003", cohort: :november, status: "active"},
    {name: "Michael Corleone", id: "004", cohort: :november, status: "active"},
    {name: "Alex DeLarge", id: "005", cohort: :november, status: "active"},
    {name: "The Wicked Witch of the West", id: "006", cohort: :november, status: "active"},
    {name: "Terminator", id: "007", cohort: :november, status: "active"},
    {name: "Freddy Krueger", id: "008", cohort: :november, status: "active"},
    {name: "The Joker", id: "009", cohort: :november, status: "active"},
    {name: "Joffrey Baratheon", id: "010", cohort: :november, status: "active"},
    {name: "Norman Bates", id: "011", cohort: :november, status: "active"}
  ]
  user_input = ""

  while user_input != "exit" do
    user_input = get_user_input("main")

    case user_input
    when "create"
      student_input = input_students
      if !student_input.empty?
        students = student_input
      end

    when "print"
      print_header
      print_students(students)
      print_footer(students)

    when "report"
      while user_input !="quit"
        user_input = get_user_input("reports")

        case user_input
        when "first letter"
          puts "\nLetter to report by:"
          report_key = gets.chomp.downcase

          report_first_letter(students,report_key)
        when "short names"
          puts "\nMax length of name:"
          report_length = gets.chomp.to_i

          report_short_names(students, report_length)
        end
      end
    end
  end
end

kernel
