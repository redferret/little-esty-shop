class Item < ApplicationRecord
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  validates :name, presence: true
  validates :unit_price, presence: true
  validates :description, presence: true

  def has_errors?
    !errors.empty?
  end

  def humanize_errors
    errors.full_messages.each_with_object("Error(s)") do |error, message|
      message << ", #{error}"
    end
  end
end
