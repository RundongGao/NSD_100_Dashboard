class MakeQuoteReferenceToCompany < ActiveRecord::Migration
  def change
  	ActiveRecord::Base.connection.execute(
  		"ALTER TABLE quote
			ADD FOREIGN KEY (symbol)
			REFERENCES company (symbol)"
	)
  end
end
