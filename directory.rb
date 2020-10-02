# Setup variables
students = [
  'Dr. Hannibal Lecter',
  "Darth Vader",
  "Nurse Ratched",
  "Michael Corleone",
  "Alex DeLarge",
  "The Wicked Witch of the West",
  "Terminator",
  "Freddy Krueger",
  "The Joker",
  "Joffrey Baratheon",
  "Norman Bates"
]

def print_header
  # print the header for the list of students
  puts "\nThe students of Ciallains Academy"
  puts "--------------"
end

def print(names)
  # print each student name
  names.each do |name|
  puts name
end

def print_footer
  # print the footer for the list of students
  print "\nOverall, we have #{students.count} great students\n\n"
end
