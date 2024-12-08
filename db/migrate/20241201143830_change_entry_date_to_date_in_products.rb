class ChangeEntryDateToDateInProducts < ActiveRecord::Migration[8.0]
  def change
    change_column :products, :entry_date, :date
  end
end
