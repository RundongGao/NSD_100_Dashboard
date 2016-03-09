require 'csv'
require 'pry'
require_relative 'importer/company_importer'
require_relative 'db/models.rb'
require_relative 'importer/quote_importer'

include CompanyImporter
include QuoteImporter

CompanyImporter.ndx_companies 'data/companylist.csv','data/nasdaq100.csv'
puts 'populating company data successful'

CompanyImporter.ndx_entry
puts 'added ndx to company table'

QuoteImporter.import '2014'
puts 'populating quote data 2014 successful'

QuoteImporter.import '2016'
puts 'populating quote data 2106 successful'