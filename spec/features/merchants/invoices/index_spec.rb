require 'rails_helper'

RSpec.describe 'The merchant index page' do
  before(:each) do
    @merchant = FactoryBot.create(:merchant)
    @item_1 = FactoryBot.create(:item, merchant: @merchant)
    @item_2 = FactoryBot.create(:item, merchant: @merchant)
    @item_3 = FactoryBot.create(:item, merchant: @merchant)
    @customer = FactoryBot.create(:customer)
    @invoice_1 = FactoryBot.create(:invoice, customer: @customer)
    @invoice_2 = FactoryBot.create(:invoice, customer: @customer)
    @invoice_3 = FactoryBot.create(:invoice, customer: @customer)
    @invoice_item_1 = FactoryBot.create(:invoice_item, item: @item_1, invoice: @invoice_1)
    @invoice_item_2 = FactoryBot.create(:invoice_item, item: @item_2, invoice: @invoice_2)

    visit merchant_invoices_path(@merchant)
  end

  describe 'invoice links,' do
    it 'navigates to the show page for an invoice' do
      click_link "Invoice ##{@invoice_1.id}"
      expect(current_path).to eq merchant_invoice_path(@merchant, @invoice_1)
    end
  end
  
  it 'shows all the invoices that have at least one of the merchants items' do
    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_content(@invoice_2.id)
    expect(page).to_not have_content(@invoice_3.id)
  end
end