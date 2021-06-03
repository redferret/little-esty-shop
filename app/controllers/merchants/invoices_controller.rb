module Merchants
  class InvoicesController < ApplicationController
    def index
      @merchant = Merchant.find(params[:merchant_id])
      @invoices = InvoiceItem.invoices_for_merchant(params[:merchant_id])
    end

    def show
      @invoice = Invoice.find(params[:id])
      @customer = Customer.find(@invoice.customer_id)
      @merchant = Merchant.find(params[:merchant_id])
      @invoice = Invoice.find(params[:id])
      @invoice_items = @invoice.invoice_items
    end

    def update
      @merchant = Merchant.find(params[:merchant_id])
      @invoice = Invoice.find(params[:id])
      @invoice.status = params[:invoice][:status]
      @invoice.save
      redirect_to merchant_invoice_path(@merchant, @invoice)
    end
  end
end