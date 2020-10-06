require 'io/console'

choices = ["report", "create", "print"]
input_full = ''

puts "What would you like to do?"
input_char = STDIN.getch

while input_char != "\r"
  input_full += input_char
  print input_char

  choices.each  do |choice|
    if input_full == choice[0..input_full.length-1]
      print choice[input_full.length..choice.length]
    end
  end

  input_char = STDIN.getch
end
print "\n"
