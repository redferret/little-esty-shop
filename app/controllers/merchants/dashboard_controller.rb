module Merchants
  class DashboardController < ApplicationController
    def index
      @merchant = Merchant.find(params[:merchant_id])
      @invoice_items = InvoiceItem.all
    end
  end
end