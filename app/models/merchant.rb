class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices

  def self.top_merchants
    []
  end

  def self.enabled_merchants
    where(enabled: true)
  end

  def self.disabled_merchants
    where(enabled: false)
  end

  def enabled_items
    items.where(status: true)
  end

  def disabled_items
    items.where(status: false)
  end
end
