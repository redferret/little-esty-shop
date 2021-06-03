class InvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = InvoiceItem.invoices_for_merchant(params[:merchant_id])
  end
end
