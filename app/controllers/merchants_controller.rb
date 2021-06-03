class MerchantsController < ApplicationController

  def dashboard
    @merchant = Merchant.find(params[:id])
    @invoice_items = InvoiceItem.all
  end

end
