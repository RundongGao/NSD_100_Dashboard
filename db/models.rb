require 'active_record'
require 'yaml'
require 'erb'

@environment = ENV['NDX_ENV'] || 'development'

template = ERB.new File.new('db/config.yml').read
@dbconfig = YAML.load template.result(binding)
ActiveRecord::Base.establish_connection @dbconfig[@environment]

class Company < ActiveRecord::Base
	has_many :quotes
	primary_key = 'symbol'
end

class Quote < ActiveRecord::Base
	belongs_to :company
end

