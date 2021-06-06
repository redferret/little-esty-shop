class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  enum status: { pending: 'pending', packaged: 'packaged', shipped: 'shipped' }

  def self.total_revenue(invoice_items)
    invoice_items.sum(:unit_price) / 100.0
  end
end
