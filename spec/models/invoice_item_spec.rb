require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe 'relationships' do
    it { should belong_to :item }
    it { should belong_to :invoice }
  end

  describe '#total_revenue' do
    it 'returns the total revenue for an invoice' do
      merchant = FactoryBot.create(:merchant)
      item_1 = FactoryBot.create(:item, merchant: merchant, unit_price: 1200)
      item_2 = FactoryBot.create(:item, merchant: merchant, unit_price: 500)
      customer = FactoryBot.create(:customer)
      invoice = Invoice.create!(status: "in_progress", customer: customer)
      FactoryBot.create(:invoice_item, item: item_1, invoice: invoice, unit_price: 1200, quantity: 1)
      FactoryBot.create(:invoice_item, item: item_2, invoice: invoice, unit_price: 500, quantity: 3)

      expect(InvoiceItem.total_revenue(invoice.invoice_items)).to eq(27.0)
    end
  end
end
