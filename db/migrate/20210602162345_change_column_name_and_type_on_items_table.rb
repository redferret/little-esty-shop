class ChangeColumnNameAndTypeOnItemsTable < ActiveRecord::Migration[5.2]
  def change
    change_table :items do |t|
      t.remove :quanity
      t.string :description
    end
  end
end
