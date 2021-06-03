class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  enum status: { pending: 'pending', packaged: 'packaged', shipped: 'shipped' }

  def self.invoice_items_ready_to_ship(merchant)
   merchant.invoice_items.where.not(status: :shipped).joins(:invoice)
   .where('invoices.status = ?', Invoice.statuses[:completed])
   .order('invoices.created_at')
  end
end
