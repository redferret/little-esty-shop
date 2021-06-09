class ChangeItemsTable < ActiveRecord::Migration[5.2]
  def change
    change_table :items do |t|
      t.boolean :status, default: true, null: false
    end
  end
end
