class AddNameColumnToCompany < ActiveRecord::Migration
  def change
  	add_column(:company, :name, :string)
  end
end
