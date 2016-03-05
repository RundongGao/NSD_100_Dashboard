class AddAdjCloseToQuotes < ActiveRecord::Migration
  def change
  	add_column(:quotes, :adj_close, :decimal)
  end
end
