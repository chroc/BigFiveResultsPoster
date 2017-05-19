# Sergio Rojas
# 19052017

require "./BigFiveResultsPoster.rb"
require "./BigFiveResultsTextSerializer.rb"
require "pry"

@text = Array.new
@results_hash = Hash.new

EMAIL = "chroc7@gmail.com"

def read_file
  f = File.open("./Big5TestResults.txt", "r")
  f.each_line do |line|
    line = line.strip
    @text.push(line)
  end
  f.close
end

read_file

serializer = BigFiveResultsTextSerializer.new(@text)
@results_hash = serializer.hash_function
puts @results_hash
poster = BigFiveResultsPoster.new(@results_hash, EMAIL)
posted = poster.post
if posted
  puts "Success!! receipt Token: #{poster.token}"
else
  puts "Something went wrong... #{poster.response_code}"
end
