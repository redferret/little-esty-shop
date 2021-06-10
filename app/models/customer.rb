class Customer < ApplicationRecord
  has_many :invoices, dependent: :destroy
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices

  def self.top_five_customers ##favorite
    #joins with transactions ?
    # where result: :success
    # select all customers  - count transaction.result - == top_five
    #order them -desc? and set the limit of 5
    joins(:transactions).where({ transactions: { result: "success"} }).
    group(:id).select("customers.*, count('transaction.result') as top_five").
    order(top_five: :desc).limit(5)
  end

  def self.most_successful_five ##admin dash
    # joins(:invoices).joins(:transactions)
    joins(invoices: :transactions)
    .where('transactions.result = ?', 'success').group(:id).select('customers.*, count(transactions.id) as most_success').order(most_success: :desc).limit(5)
  end

  def count_best
    Transaction.joins(invoice: :customer).where("customers.id = ?", self.id).where(transactions: {result: :success}).group('transactions.id').count.size
    # self.joins(invoices: :transactions).group('transactions.id').where(transactions: {result: :success}).values.count
  end
end

#   def self.top_five
#     joins(invoices: :transactions)
#     .group(:id)
#     .where("transactions.result = ?", 1)
#     .select("customers.*, count(transactions.id) as num_transactions")
#     .order(num_transactions: :desc)
#     .limit(5)
#   end
