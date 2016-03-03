class CreateQuote < ActiveRecord::Migration
  def change
    create_table :quote do |t|
    	t.string :symbol
      	t.date :date
      	t.decimal :open
      	t.decimal :close
      	t.decimal :high
      	t.decimal :low
      	t.integer :volume
    end
    add_index :quote, [:symbol, :date], :unique => true
  end
end
