def receipt(price, fees)
  r = 
  "\
  Bitcoin Data - #{Time.now.strftime("%m/%e/%Y at%l:%M %p %Z")}\n\
  #{?=*47}\n\
  Price#{" " * 14}$#{price}\n\n\
  Fastest TX fee#{" " * 5}#{fees[0]} sats/vByte\n\
  Half hour TX fee#{" " * 3}#{fees[1]} sats/vByte\n\
  One hour TX fee#{" " * 4}#{fees[2]} sats/vByte"
end

puts receipt("25,000", [1000,500,50])
