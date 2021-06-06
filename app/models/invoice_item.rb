class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  enum status: { pending: 'pending', packaged: 'packaged', shipped: 'shipped' }

  def self.total_revenue(invoice_items)

    invoice_items.distinct.pluck(sum(:quantity) * sum(:unit_price))[0].to_f / 100
  end
end
