class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items

  def self.top_merchants
    joins(:invoice_items).order(Arel.sql('invoice_items.unit_price * invoice_items.quantity DESC')).limit(5)
  end

  def self.enabled_merchants
    where(enabled: true)
  end

  def self.disabled_merchants
    where(enabled: false)
  end
end
