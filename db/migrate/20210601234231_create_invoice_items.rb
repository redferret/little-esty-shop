class CreateInvoiceItems < ActiveRecord::Migration[5.2]
  def change
    create_enum :item_status, %w[pending packaged shipped]

    create_table :invoice_items do |t|
      t.enum :status, enum_name: :item_status, default: 'pending', null: false
      t.integer :quantity
      t.integer :unit_price
      t.references :item, foreign_key: true
      t.references :invoice, foreign_key: true

      t.timestamps
    end
  end
end
