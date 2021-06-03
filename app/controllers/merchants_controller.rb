class MerchantsController < ApplicationController

  def dashboard
    @merchant = Merchant.find(params[:id])
    # require "pry"; binding.pry
    # @items_ready_to_ship = @merchant.invoice_items_ready_to_ship
    @invoice_items = InvoiceItem.all
  end

end
