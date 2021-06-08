class Item < ApplicationRecord
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  validates :name, presence: true
  validates :unit_price, presence: true
  validates :description, presence: true

  def self.convert_unit_price_to_cents(unit_price)
    unit_price * 100.0
  end

  def convert_unit_price_to_dollars
    unit_price / 100.0
  end

  def has_errors?
    !errors.empty?
  end

  def humanize_errors
    errors.full_messages.each_with_object("Error(s)") do |error, message|
      message << ", #{error}"
    end
  end

  def self.most_popular_items(merchant_id)
    joins(:invoice_items).where(merchant_id: merchant_id).order(Arel.sql('invoice_items.unit_price * invoice_items.quantity DESC')).limit(5)
  end
end
