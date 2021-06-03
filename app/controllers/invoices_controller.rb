class InvoicesController < ApplicationController
  def index
    @invoices = InvoiceItem.invoices_for_merchant(params[:merchant_id])
  end
end
