class Invoice < ApplicationRecord
  has_many :transactions, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
  belongs_to :customer

  enum status: {in_progress: 'in progress', cancelled: 'cancelled', completed: 'completed'}

  # enum status: [ 'in progress', 'cancelled', 'completed' ]

  def self.ready_to_ship_invoices_for_merchant(merchant_id)
    Invoice.joins(:invoice_items, :items).where(items: {merchant_id: merchant_id}, invoice_items: {status: 'packaged'})
  end

  def self.invoices_for_merchant(merchant_id)
    Invoice.joins(:items).where(items: {merchant_id: merchant_id})
  end

  def invoice_creation_date
    created_at.strftime("%A, %B %d, %Y")
  end

  def self.incomplete_oldest_first
    Invoice.joins(:invoice_items)
    .where.not("invoice_items.status = ?", "shipped")
    .order(created_at: :desc).distinct
  end
end
