class Merchants::DashboardController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = Invoice.ready_to_ship_invoices_for_merchant(params[:merchant_id])
    @customers = @merchant.customers
    # @top_five_customers = Customer.top_five_customers
  end
end
