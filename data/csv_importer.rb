require 'csv'

module CsvImporter
	def calcualte_market_cap s
		return unless s
		num = s[1..-2].to_f
		return num if s[-1] == 'M'
		num * 1000
	end

	def import_company_table all_companies_file, nsq_companies_files
		all_companies_text = File.read(all_companies_file)
		all_companies = CSV.parse(all_companies_text, :headers => true)
		unused_columns = ['LastSale', 'IPOyear', 'Summary Quote', nil]
		unused_columns.each do |c|
			all_companies.delete(c)
		end

		nsq_companies_text = File.read(nsq_companies_files)
		nsq_companies = CSV.parse(nsq_companies_text, :headers => true)
		nsq_list = nsq_companies['ticker']

		all_companies.each_entry do |e|
			next unless nsq_list.include? e[0] 
			Company.find_or_create_by(symbol: e[0]) do |r|
	  			r.name = e[1]
				r.market_cap_m = calcualte_market_cap(e[2])
				r.sector = e[3]
				r.industory = e[4]
			end	
		end
	end
end

