require 'csv'
require 'pry'
require_relative 'importer/company_importer'
require_relative 'db/models.rb'
require_relative 'importer/quote_importer'

#path on linux server
Dir.chdir("/ndx_code/NSD_100_Dashboard") if ENV['NDX_ENV'] == 'production'

include CompanyImporter
include QuoteImporter

QuoteImporter.import 'update'
puts 'pudating quote data 2106 successful'
