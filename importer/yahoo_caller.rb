require 'rest-client'
require 'csv'
require 'date'

module YahooCaller
	# taking a stock_symbol (string)
	# return a CSV object of returned data from Yahoo
	def get_2014_data stock_symbol
		response = RestClient.get(
			"http://ichart.finance.yahoo.com/table.csv?s=#{stock_symbol}&a=0&b=1&c=2014&d=11&e=31&f=2014&g=d&ignore=.csv"
		)
		CSV.parse(response, :headers => true)
	end

	def get_2016_data stock_symbol
		response = RestClient.get(
			"http://ichart.finance.yahoo.com/table.csv?s=#{stock_symbol}&a=0&b=1&c=2016&#{generate_to_date_flag 0}&g=d&ignore=.csv"
		)
		CSV.parse(response, :headers => true)
	end

	def update_data stock_symbol
		response = RestClient.get(
			"http://ichart.finance.yahoo.com/table.csv?s=#{stock_symbol}&#{generate_from_date_flag 3}&#{generate_to_date_flag 0}&g=d&ignore=.csv"
		)
		CSV.parse(response, :headers => true)
	end

	def generate_from_date_flag days
		today = Date.today
		day, month, year = (today.day - days).to_s, (today.month - 1).to_s, today.year.to_s
		"a=#{month}&b=#{day}&c=#{year}"
	end

	def generate_to_date_flag days
		today = Date.today
		day, month, year = (today.day - days).to_s, (today.month - 1).to_s, today.year.to_s
		"d=#{month}&e=#{day}&f=#{year}"
	end
end

