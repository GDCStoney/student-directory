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
    id_string = ("000" + students.count.to_s).split('').last(3).join
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
      puts "#{student[:id]} - " + student[:name].center(max_name_length) + " (#{student[:cohort]} cohort)"
    end
  end
end

def print_footer(names)
  # print the footer for the list of students
  puts "\nOverall, we have #{names.select { |student| student[:status] == "active" }.count} great students\n"
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
    puts "\nWhat would you like to do? '?' for help"
    user_input = gets.chomp.downcase

    case user_input
    when "?"
      puts "'create' 'print' 'report' 'exit'"
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
        puts "\nWhich report? '?' for help"
        user_input = gets.chomp.downcase

        case user_input
        when "?"
          puts "'first letter', 'short name', 'quit'"
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
