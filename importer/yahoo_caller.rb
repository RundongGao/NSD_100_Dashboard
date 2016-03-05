require 'rest-client'
require 'csv'

module YahooCaller
	# taking a stock_symbol (string)
	# return a CSV object of returned data from Yahoo
	def get_2014_data stock_symbol
		response = RestClient.get(
			"http://ichart.finance.yahoo.com/table.csv?s=#{stock_symbol}&a=0&b=1&c=2014&d=11&e=31&f=2014&g=d&ignore=.csv"
		)
		CSV.parse(response, :headers => true)
	end
end
