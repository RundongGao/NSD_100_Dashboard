class MakeCompanySymblePk < ActiveRecord::Migration
  def change
  	add_index :company, :symbol, :unique => true
  end
end
