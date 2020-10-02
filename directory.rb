# Setup variables
students = [
  {name: 'Dr. Hannibal Lecter', cohort: :november},
  {name: "Darth Vader", cohort: :november},
  {name: "Nurse Ratched", cohort: :november},
  {name: "Michael Corleone", cohort: :november},
  {name: "Alex DeLarge", cohort: :november},
  {name: "The Wicked Witch of the West", cohort: :november},
  {name: "Terminator", cohort: :november},
  {name: "Freddy Krueger", cohort: :november},
  {name: "The Joker", cohort: :november},
  {name: "Joffrey Baratheon", cohort: :november},
  {name: "Norman Bates", cohort: :november}
]

def input_students
  puts "Please enter the names of the students"
  puts "to finish, just hit return twice"
  # create an empty array unless first entry is ""
  students =[]
  name = gets.chomp
  # while name is not empty, get details
  while !name.empty? do
    # create student hash in students array
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
    name =gets.chomp
  end
  # return the array of students or empty
  students
end

def print_header
  # print the header for the list of students
  puts "\nThe students of Ciallains Academy"
  puts "--------------"
end

def print_students(students)
  # print each student name
  students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer(names)
  # print the footer for the list of students
  puts "\nOverall, we have #{names.count} great students\n\n"
end

# run methods
# fill student list
student_input = input_students
if !student_input.empty?
  students = student_input
end
# print the student list
print_header
print_students(students)
print_footer(students)
