require 'rails_helper'

RSpec.describe 'admin dashboard page', type: :feature do
  it 'has link to admin dashboard' do
    visit '/admin/dashboard'
    expect(page).to have_link('Dashboard')
    click_on('Dashboard')
    expect(current_path).to eq("/admin/dashboard")
  end

  it 'has link to admin merchants items index' do
    visit '/admin/dashboard'
    expect(page).to have_link('Merchants')
    click_on('Merchants')
    expect(current_path).to eq("/admin/merchants")
  end

  it 'has link to admin invoices index' do
    visit '/admin/dashboard'
    expect(page).to have_link('Invoices')
    click_on('Invoices')
    expect(current_path).to eq("/admin/invoices")
  end

  it 'has a header indicating admin dashboard, column titles' do
    visit '/admin/dashboard'
    expect(page).to have_content("Admin Dashboard")
    expect(page).to have_content("Incomplete Invoices")
    expect(page).to have_content("Top Customers")
  end

  describe 'it has an incomplete invoices section' do
    before :each do
      @customer_1 = FactoryBot.create(:customer)
      @customer_2 = FactoryBot.create(:customer)
      @invoice_1 = FactoryBot.create(:invoice, customer: @customer_1)
      @invoice_2 = FactoryBot.create(:invoice, customer: @customer_1)
      @invoice_3 = FactoryBot.create(:invoice, customer: @customer_2)
      @invoice_4 = FactoryBot.create(:invoice, customer: @customer_2)

      @merchant_1 = FactoryBot.create(:merchant)
      @item_1 = FactoryBot.create(:item, merchant: @merchant_1)
      @item_2 = FactoryBot.create(:item, merchant: @merchant_1)

      @invoice_item_1 = FactoryBot.create(:invoice_item, item: @item_1, invoice: @invoice_1, status: 'pending')
      @invoice_item_2 = FactoryBot.create(:invoice_item, item: @item_1, invoice: @invoice_2, status: 'pending')
      @invoice_item_2 = FactoryBot.create(:invoice_item, item: @item_2, invoice: @invoice_2, status: 'shipped')
      @invoice_item_3 = FactoryBot.create(:invoice_item, item: @item_1, invoice: @invoice_3, status: 'shipped')
      @invoice_item_4 = FactoryBot.create(:invoice_item, item: @item_2, invoice: @invoice_4, status: 'packaged')
    end

    it 'lists all incomplete invoices' do
      visit '/admin/dashboard'

      within("#incomplete_invoices") do
        expect(page).to have_content("Incomplete Invoices")
        expect(page).to have_content(@invoice_1.id)
        expect(page).to have_content(@invoice_2.id)
        expect(page).to have_content(@invoice_4.id)
        expect(page).to_not have_content(@invoice_3.id)
      end
    end
  end
end
