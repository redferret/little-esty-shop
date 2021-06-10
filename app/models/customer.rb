class Customer < ApplicationRecord
  has_many :invoices, dependent: :destroy
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices

  def self.top_five_customers
    #joins with transactions ?
    # where result: :success
    # select all customers  - count transaction.result - == top_five
    #order them -desc? and set the limit of 5
    joins(:transactions).where({ transactions: { result: "success"} }).
    group(:id).select("customers.*, count('transaction.result') as top_five").
    order(top_five: :desc).
    limit(5)
  end
end
