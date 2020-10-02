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

# print the list of students
puts "\nThe students of Ciallains Academy"
puts "--------------"
students.each do |student|
  puts student
end
# print the total number of students
print "\nOverall, we have #{students.count} great students\n\n"
