require './temp.rb'

while true
  Temp.new.set_temp
  puts "Set the temp. Waiting 60 seconds...\n"
  sleep 60
end