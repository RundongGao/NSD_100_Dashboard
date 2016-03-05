class ChangeQuotesVolumType < ActiveRecord::Migration
  def change
  	change_column(:quotes, :volume, :bigint)
  end
end
