require 'active_record'
require 'yaml'
require 'erb'

@environment = ENV['NDX_ENV'] || 'development'

template = ERB.new File.new('db/config.yml').read
@dbconfig = YAML.load template.result(binding)
binding.pry
ActiveRecord::Base.establish_connection @dbconfig[@environment]

=begin
ActiveRecord::Base.establish_connection(
  :adapter  => 'postgresql',
  :host     => "localhost",
  :username => 'nsd_100_admin',
  :password => '-<3Y%Y"_xfr?nai',
  :database => 'nsd_100'
)
=end
class Company < ActiveRecord::Base
	has_many :quotes
	primary_key = 'symbol'
end

class Quote < ActiveRecord::Base
	belongs_to :company
end

