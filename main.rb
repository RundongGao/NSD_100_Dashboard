require 'pry'
require_relative 'data/csv_importer'
require_relative 'db/models.rb'
include CsvImporter

CsvImporter.import_company_table 'data/companylist.csv','data/nasdaq100.csv'