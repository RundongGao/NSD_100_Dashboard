class RenameTables < ActiveRecord::Migration
  def change
  	rename_table :company, :companies
  	rename_table :quote, :quotes
  end
end
