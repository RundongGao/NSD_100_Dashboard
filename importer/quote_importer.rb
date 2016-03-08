require_relative 'yahoo_caller'



module QuoteImporter
	include YahooCaller

	def import data_source
		company_symbol = Company.select('symbol').to_a.map {|e| e.symbol }
		# iterate through each symbols fetched form companies table
		company_symbol.each do |s|
		begin
			# calling different yahoo caller based on data_source
				case data_source
				when '2014'
					quote_data = get_2014_data(s)
				when '2016'
					quote_data = get_2016_data(s)
				when 'update'
					quote_data = update_data(s)
				else
					puts "unknow data source #{data_source.to_s}"
				end
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

	def quote_all_2016
		company_symbol = Company.select('symbol').to_a.map {|e| e.symbol }
		company_symbol.each do |s|
		begin
			quote_data = get_2016_data(s)
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

	def quote_update
		company_symbol = Company.select('symbol').to_a.map {|e| e.symbol }
		company_symbol.each do |s|
		begin
			quote_data = update_data(s)
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
