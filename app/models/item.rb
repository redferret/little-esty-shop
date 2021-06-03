class Item < ApplicationRecord
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  def self.invoice_items_ready_to_ship
    joins(:invoice).where(status: :in_progress)
   .where('invoices.status = ?', Invoice.statuses[:completed])
   .order('invoices.created_at')
  end
end
