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
    puts "#{index + 1}. #{student[:name]} (#{student[:cohort].capitalize} cohort)"
  end
end

def print_footer
  puts "\nOverall, we have #{@students.count} great students"
end

def input_students
  puts "Please enter the 'name' : 'cohort' of the students"
  puts "To finish, just hit return twice"

  students = []

  student = STDIN.gets.chomp
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

    student = STDIN.gets.chomp
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

def load_students(filename = "students.csv")
  @students = []
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(',')
    @students << {name: name, cohort: cohort.to_sym}
  end
  file.close
end

def load_students_at_launch
  filename = ARGV.first
  return if filename.nil?
  if File.exists?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry, #{filename} doesn't exist"
  end
end

def print_menu
  puts "\n1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load students from students.csv"
  puts "9. Exit"
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def show_students
  print_header
  print
  print_footer
end

def process(selection)
  case selection
  when "1"
    @students = intput_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    load_students
  when "9"
    exit
  else
    puts "I don't know what you meant, try again"
  end
end

load_students_at_launch
interactive_menu
