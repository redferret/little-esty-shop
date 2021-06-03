class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  enum status: { pending: 'pending', packaged: 'packaged', shipped: 'shipped' }


  def self.invoices_for_merchant(merchant_id)
    where(item_id: Item.where(merchant_id: merchant_id).pluck(:id)).distinct.pluck(:invoice_id)
  end
end
