class Admin::InvoicesController < ApplicationController
  def index

  end

  def show
    @invoice_items = InvoiceItem.where(invoice_id: params[:id])
  end
end
