class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items

  def enabled_items
    items.where(status: true)
  end

  def disabled_items
    items.where(status: false)
  end
end
