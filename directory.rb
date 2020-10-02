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
  students.each_with_index do |student, index|
    if student[:status] == "active"
      puts "#{student[:id]} - #{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

def print_footer(names)
  # print the footer for the list of students
  puts "\nOverall, we have #{names.select { |student| student[:status] == "active" }.count} great students\n\n"
end

def report_first_letter(students, report_key)
  students.each_with_index do |student, index|
    puts "#{('000' + (index + 1).to_s).split('').last(3).join}"
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
    puts "What would you like to do? '?' for help"
    user_input = gets.chomp.downcase

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
        puts "Which report? '?' for help"
        user_input = gets.chomp.downcase

        case user_input
        when "first letter"
#          puts "Letter to report by:"
#          report_key = gets.chomp.downcase
#
#
#        print_header
#        report
        end
      end
    end
  end
end

kernel
