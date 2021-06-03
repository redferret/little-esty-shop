class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
end
