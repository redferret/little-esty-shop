class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items

  def self.top_merchants
    []
  end

  def self.enabled_merchants
    where(enabled: true)
  end

  def self.disabled_merchants
    where(enabled: false)
  end
end
