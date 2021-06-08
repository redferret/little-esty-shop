class Customer < ApplicationRecord
  has_many :invoices, dependent: :destroy
  has_many :transactions, through: :invoices

  def self.top_five_customers
    #joins with transactions ?
    # where result: :success
    # select all customers  - count transaction.result - == top_five
    #order them -desc? and set the limit(5)
  end
end
