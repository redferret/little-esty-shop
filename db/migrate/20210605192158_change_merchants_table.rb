class ChangeMerchantsTable < ActiveRecord::Migration[5.2]
  def change
    change_table :merchants do |t|
      t.boolean :enabled, default: true, null: false
    end
  end
end
