class CreateInvoices < ActiveRecord::Migration[5.2]
  def change
    create_enum :invoice_status, ['in progress', 'cancelled', 'completed']

    create_table :invoices do |t|
      t.enum :status, enum_name: :invoice_status, default: 'in progress', null: false
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
