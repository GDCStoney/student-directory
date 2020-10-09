@students = [
  {name: "Dr. Hannibal Lecter", cohort: :november},
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
  puts "\nThe students of Villains Academy"
  puts "------------------------\n"
end

def print
  @students.each_with_index do |student, index|
    puts "#{index}. #{student[:name]} (#{student[:cohort].capitalize} cohort)"
  end
end

def print_footer
  puts "\nOverall, we have #{@students.count} great students"
end

def input_students
  puts "Please enter the 'name' : 'cohort' of the students"
  puts "To finish, just hit return twice"

  students = []

  student = gets.chomp
  while !student.empty? do
    if student.split(":")[0].empty?
      student_name = "TBC"
    else
      student_name = student.split(":")[0]
    end

    if student.split(":")[1].empty?
      student_cohort = "TBC"
    else
      student_cohort = student.split(":")[1].to_sym
    end

    students << {name: student_name, cohort: student_cohort}
    if students.count == 1 then
      puts "Now we have #{students.count} student"
    else
      puts "Now we have #{students.count} students"
    end

    student = gets.chomp
  end

  if students == []
    @students
  else
    students
  end
end

def save_students
  file = File.open("students.csv", "w")
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def interactive_menu
  loop do
    puts "\n1. Input the students"
    puts "2. Show the students"
    puts "3. Save the list to students.csv"
    puts "9. Exit"

    selection = gets.chomp

    case selection
    when "1"
      @students = intput_students
    when "2"
      print_header
      print
      print_footer
    when "3"
      save_students
    when "9"
      exit
    else
      puts "I don't know what you meant, try again"
    end
  end
end

interactive_menu
