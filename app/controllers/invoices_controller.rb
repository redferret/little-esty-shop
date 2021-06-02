class InvoicesController < ApplicationController
  def index
    @invoices = InvoiceItem.where(item_id: Item.where(merchant_id: 1).pluck(:id))
  end

  def show
    @invoice = Invoice.find(params[:id])
    @customer = Customer.find(@invoice.customer_id)
  end
end
