require_relative 'yahoo_caller'



module QuoteImporter
	include YahooCaller

	def quote_all_2014
		company_symbol = Company.select('symbol').to_a.map {|e| e.symbol }
		company_symbol.each do |s|
		begin
			quote_data = get_2014_data(s)
			upsert_quote_data quote_data, s
		rescue Exception => e
			if e.message == "404 Resource Not Found"
				puts "404 : historical quote for #{s} do not exist"
			else
				puts e.message
			end
		end
		end
	end

	def upsert_quote_data quote_data, s
		quote_data.each_entry do |e|
			Quote.find_or_create_by(symbol: s, date: e['Date']) do |r|
	  			r.open = e['Open']
	  			r.close = e['Close']
	  			r.high = e['High']
	  			r.low = e['Low']
	  			r.volume = e['Volume']
	  			r.adj_close = e['Adj Close']
			end
		end
	end
end
