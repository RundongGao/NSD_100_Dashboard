
module CompanyImporter

	def ndx_entry
		Company.find_or_create_by(symbol: '%5ENDX')
	end

	def ndx_companies all_companies_file, nsq_companies_files
		all_companies_text = File.read(all_companies_file)
		all_companies = CSV.parse(all_companies_text, :headers => true)

		unused_columns = ['LastSale', 'IPOyear', 'Summary Quote', nil]
		unused_columns.each do |c|
			all_companies.delete(c)
		end

		nsq_companies_text = File.read(nsq_companies_files)
		nsq_companies = CSV.parse(nsq_companies_text, :headers => true)
		nsq_list = nsq_companies['ticker']

		upsert_company_data all_companies, nsq_list
	end

	def calcualte_market_cap s
		return unless s
		num = s[1..-2].to_f
		return num if s[-1] == 'M'
		num * 1000
	end

	def upsert_company_data all_companies, nsq_list
		all_companies.each_entry do |e|
			next unless nsq_list.include? e['Symbol'] 
			Company.find_or_create_by(symbol: e['Symbol']) do |r|
	  			r.name = e['Name']
				r.market_cap_m = calcualte_market_cap(e['MarketCap'])
				r.sector = e['Sector']
				r.industory = e['industry']
			end	
		end
	end

end

