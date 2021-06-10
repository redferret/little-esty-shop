class Admin::DashboardController < ApplicationController
  def index
    @incomplete_invoices = Invoice.incomplete_oldest_first
    @top_customers = Customer.most_successful_five
  end
end
