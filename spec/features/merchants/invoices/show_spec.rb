require 'rails_helper'

RSpec.describe 'show' do
  before(:each) do
    @merchant = FactoryBot.create(:merchant)

    @item_1 = FactoryBot.create(:item, merchant: @merchant)
    @item_2 = FactoryBot.create(:item, merchant: @merchant, unit_price: 1200)
    @item_3 = FactoryBot.create(:item, merchant: @merchant, unit_price: 500)

    @customer = FactoryBot.create(:customer)

    @invoice_1 = Invoice.create!(status: "in_progress", customer: @customer)

    @invoice_2 = Invoice.create!(status: "in_progress", customer: @customer)
    @invoice_item_1 = FactoryBot.create(:invoice_item, item: @item_1, invoice: @invoice_1)
    @invoice_item_2 = FactoryBot.create(:invoice_item, item: @item_2, invoice: @invoice_2, unit_price: 1200)
    @invoice_item_3 = FactoryBot.create(:invoice_item, item: @item_3, invoice: @invoice_2, unit_price: 1500)
  end

  describe 'invoice item show,' do
    before :each do
      visit merchant_invoice_path(@merchant, @invoice_1)
    end

    it 'shows the invoice attributes' do
      within '#invoice-info' do
        expect(page).to have_content("#{@invoice_1.id}")
        expect(page).to have_content("#{@invoice_1.status}")
        expect(page).to have_content("#{@invoice_1.created_at}")
        expect(page).to have_content("#{@customer.first_name}")
        expect(page).to have_content("#{@customer.last_name}")
      end
    end

    describe 'invoice status form,' do
      it 'can update a invoice status' do
        expect(page).to have_select("invoice[status]", selected: @invoice_1.status)
        click_on("Update Item Status")
        expect(current_path).to eq(merchant_invoice_path(@merchant, @invoice_1))
      end
    end
  end
  
  describe 'total revenue' do
    it 'shows the total revenue for the invoice' do
      visit merchant_invoice_path(@merchant, @invoice_2)

      within '#invoice-info' do
        expect(page).to have_content("Total Revenue: $27.0")
      end
    end
  end
end