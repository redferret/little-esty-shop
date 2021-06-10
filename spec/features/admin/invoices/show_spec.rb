require 'rails_helper'

RSpec.describe 'admin invoice show' do
  before(:each) do
    @merchant = FactoryBot.create(:merchant)
    @item_1 = FactoryBot.create(:item, merchant: @merchant)
    @customer = FactoryBot.create(:customer)
    @invoice_1 = Invoice.create!(status: "in_progress", customer: @customer)
    @invoice_item_1 = FactoryBot.create(:invoice_item, item: @item_1, invoice: @invoice_1)
  end

  describe 'invoice items show' do
    before :each do
      visit admin_invoice_path(@merchant, @invoice_1)
    end

    it 'shows the invoice items info' do
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@invoice_item_1.quantity)
      expect(page).to have_content(@invoice_item_1.unit_price)
      expect(page).to have_content(@invoice_item_1.status)
    end

    it 'shows the invoice items info' do
      expect(page).to have_content(@invoice_1.id)
      expect(page).to have_content(@invoice_1.created_at)
      expect(page).to have_content(@invoice_1.status)
      expect(page).to have_content(@customer.first_name)
      expect(page).to have_content(@customer.last_name)
    end
  end
end
