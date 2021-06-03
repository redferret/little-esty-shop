class InvoicesController < ApplicationController
  def index

  end

  def show
    @customer = Customer.find(params[:id])
    @invoice = Invoice.find(params[:id])
    @invoice_item = InvoiceItem.find(params[:id])
  end
end
