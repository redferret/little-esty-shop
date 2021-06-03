class InvoicesController < ApplicationController
  def index

  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:id])
    @invoice_item = InvoiceItem.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:id])
    @invoice.status = params[:invoice][:status]
    @invoice.save
    redirect_to merchant_invoice_path(@merchant, @invoice)
  end
end
