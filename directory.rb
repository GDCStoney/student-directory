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
print_header
print_students(students)
print_footer(students)
