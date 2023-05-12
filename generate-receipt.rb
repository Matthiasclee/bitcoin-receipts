def receipt(price, fees)
  d="#{Time.now.strftime("%a, %b %e, %Y at%l:%M %p %Z")}"

  p = "$#{price}"
  fh = "#{fees[0]} sats/vByte"
  fm = "#{fees[1]} sats/vByte"
  fl = "#{fees[2]} sats/vByte"

  r = 
  "\
  Bitcoin Data#{" " * (47-12-d.length)}#{d}\n\
  #{?=*47}\n\
  Price#{" " * (47-6-p.length)}#{p}\n\n\
  Fastest TX fee#{" " * (47-14-fh.length)}#{fh}\n\
  Half hour TX fee#{" " * (47-16-fm.length)}#{fm}\n\
  One hour TX fee#{" " * (47-15-fl.length)}#{fl}"
end

puts receipt("25,000", [1000,500,50])
