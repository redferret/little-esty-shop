require 'rails_helper'

RSpec.describe 'show' do
  before(:each) do
    @merchant = FactoryBot.create(:merchant)
    @item_1 = FactoryBot.create(:item, merchant: @merchant)
    @item_2 = FactoryBot.create(:item, merchant: @merchant)
    @item_3 = FactoryBot.create(:item, merchant: @merchant)
    @customer = FactoryBot.create(:customer)
    @invoice_1 = FactoryBot.create(:invoice, customer: @customer)
    FactoryBot.create(:invoice_item, item: @item_1, invoice: @invoice_1)
    FactoryBot.create(:invoice_item, item: @item_2, invoice: @invoice_1)
    FactoryBot.create(:invoice_item, item: @item_3, invoice: @invoice_1)

    visit "/merchants/#{@merchant.id}/invoices"
    click_link "#{@invoice_1.id}"
  end

  it 'goes to the invoices show page with the invoices information' do
    expect(page).to have_content("#{@invoice_1.id}")
    expect(page).to have_content("#{@invoice_1.status}")
    expect(page).to have_content("#{@invoice_1.created_at}")
    expect(page).to have_content("#{@customer.first_name}")
    expect(page).to have_content("#{@customer.last_name}")
  end
end