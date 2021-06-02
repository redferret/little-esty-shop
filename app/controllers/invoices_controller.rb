class InvoicesController < ApplicationController
  def index
    @invoices = InvoiceItem.where(item_id: Item.where(merchant_id: 1).pluck(:id))
  end
end
