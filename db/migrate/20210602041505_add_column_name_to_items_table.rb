class AddColumnNameToItemsTable < ActiveRecord::Migration[5.2]
  def change
    change_table :items do |t|
      t.string :name
    end
  end
end
