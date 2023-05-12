require "json"
require "net/http"

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
  Price#{" " * (47-5-p.length)}#{p}\n\n\
  Fastest TX fee#{" " * (47-14-fh.length)}#{fh}\n\
  Half hour TX fee#{" " * (47-16-fm.length)}#{fm}\n\
  One hour TX fee#{" " * (47-15-fl.length)}#{fl}"
end

# Get data
price = Net::HTTP.get(URI("https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=USD"))
price = JSON.parse(price)["USD"].to_i.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\1,').reverse

fees = Net::HTTP.get(URI("https://bitcoinfees.earn.com/api/v1/fees/recommended"))
fees = JSON.parse(fees)


puts receipt(price,
            [fees["fastestFee"],
            fees["halfHourFee"],
            fees["hourFee"]]
            )
