class CreateCompanyTable < ActiveRecord::Migration
  def change
    create_table :company do |t|
    	t.string :symbol
      	t.decimal :market_cap_m
      	t.string :sector
      	t.string :industory
    end
  end
end
