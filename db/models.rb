require 'active_record'
require 'pry'

ActiveRecord::Base.establish_connection(
  :adapter  => 'postgresql',
  :host     => "localhost",
  :username => 'nsd_100_admin',
  :password => '-<3Y%Y"_xfr?nai',
  :database => 'nsd_100'
)

class Company < ActiveRecord::Base
	has_many :quotes
	primary_key = 'symbol'
end

class Quote < ActiveRecord::Base
	belongs_to :company
end

