require "json"
require "net/http"

def receipt(price, fees)
  d="#{Time.now.strftime("%m/%e/%Y %l:%M %p %Z")}"

  p = "$#{price}"
  fh = "#{fees[0]} sat/vB"
  fm = "#{fees[1]} sat/vB"
  fl = "#{fees[2]} sat/vB"

  r = 
  "\
Bitcoin Data#{" " * (47-12-d.length)}#{d}\n\
#{?=*47}\n\
| Price#{" " * (43-5-p.length)}#{p} |\n|#{" " * 45}|\n\
| Fastest TX fee#{" " * (43-14-fh.length)}#{fh} |\n\
| Half hour TX fee#{" " * (43-16-fm.length)}#{fm} |\n\
| One hour TX fee#{" " * (43-15-fl.length)}#{fl} |"
end

# Get data
begin
  response = Net::HTTP.get(URI("https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=USD"))
  price = JSON.parse(response)["USD"].to_i.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\1,').reverse

  if JSON.parse(response)["Response"] == "Error"
    price = "-----"
  end
rescue
  price = "-----"
end

begin
fees = Net::HTTP.get(URI("https://mempool.space/api/v1/fees/recommended"))
fees = JSON.parse(fees)
rescue
  fees = {
    "fastestFee" => "--",
    "halfHourFee" => "--",
    "hourFee" => "--"
  }
end


puts receipt(price,
            [fees["fastestFee"],
            fees["halfHourFee"],
            fees["hourFee"]]
            )
