class Merchants::InvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = Invoice.invoices_for_merchant(@merchant.id)
  end

  def show
    @invoice = Invoice.find(params[:id])
    @customer = Customer.find(@invoice.customer_id)
    @merchant = Merchant.find(params[:merchant_id])
    @invoice_items = @invoice.invoice_items
    @total_revenue = InvoiceItem.total_revenue(@invoice_items)
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:id])
    @invoice.status = params[:invoice][:status]
    @invoice.save
    redirect_to merchant_invoice_path(@merchant, @invoice)
  end
end
