class Invoice < ApplicationRecord
  has_many :transactions, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
  belongs_to :customer

  enum status: {in_progress: 'in progress', cancelled: 'cancelled', completed: 'completed'}
end
