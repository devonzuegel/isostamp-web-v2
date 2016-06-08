require 'awesome_print'
require 'colorize'

PORT = 'tcp:3000'

def get_lines
  `lsof -i #{PORT}`.split("\n")
end

first_iteration = true

loop do
  lines = get_lines

  ruby_index = lines.index { |l| l =~ /^ruby/ }
  if ruby_index.nil?
    puts "No ruby process found on port #{PORT}".gray
    exit 0
  end

  if first_iteration
    puts "BEFORE:".gray
    lines.each { |l| puts l }
    first_iteration = false
  end

  pid = lines[ruby_index].split[1]
  `kill -9 #{pid}`
  puts "Killed process with pid = #{pid}".green
end

puts 'AFTER:'.gray
puts get_lines