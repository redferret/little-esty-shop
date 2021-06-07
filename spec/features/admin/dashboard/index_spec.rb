require 'rails_helper'

RSpec.describe 'admin dashboard page', type: :feature do

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

    visit admin_dashboard_index_path
  end

  it 'has link to admin merchants items index' do
    within '#navbarNav' do
      expect(page).to have_link('Merchants', href: admin_merchants_path)
      click_on('Merchants')
    end
    expect(current_path).to eq("/admin/merchants")
  end

  it 'has link to admin dashboard' do
    within '#navbarNav' do
      expect(page).to have_link('Dashboard', href: admin_dashboard_index_path)
      click_on('Dashboard')
    end
    expect(current_path).to eq("/admin/dashboard")
  end

  it 'has link to admin invoices index' do
    within '#navbarNav' do
      expect(page).to have_link('Invoices', href: admin_invoices_path)
      click_on('Invoices')
    end
    expect(current_path).to eq("/admin/invoices")
  end

  it 'has a header indicating admin dashboard, column titles' do
    expect(page).to have_content("Admin Dashboard")
    expect(page).to have_content("Incomplete Invoices")
    expect(page).to have_content("Top Customers")
  end

  describe 'it has an incomplete invoices section' do
    it 'lists all incomplete invoices' do
      within("#incomplete_invoices") do
        expect(page).to have_content("Incomplete Invoices")
        expect(page).to have_content(@invoice_1.id)
        expect(page).to have_content(@invoice_2.id)
        expect(page).to have_content(@invoice_4.id)
        expect(page).to_not have_content(@invoice_3.id)
      end
    end

    it 'orders the invoices from oldest to newest
    and displays invoice created at date like "Monday, July 18,2019"' do
      within("#incomplete_invoices") do
        expect(page).to have_content("Incomplete Invoices")

        invoice_4_div = find("#incomplete_invoice-#{@invoice_4.id}")
        invoice_2_div = find("#incomplete_invoice-#{@invoice_2.id}")
        invoice_1_div = find("#incomplete_invoice-#{@invoice_1.id}")
        
        expect(invoice_4_div).to appear_before(invoice_2_div)
        expect(invoice_2_div).to appear_before(invoice_1_div)

        within("#incomplete_invoice-#{@invoice_4.id}") do
          expect(page).to have_content("#{@invoice_4.id}")
          expect(page).to have_content("#{@invoice_4.created_at.strftime("%A, %B %d, %Y")}")
        end

        within("#incomplete_invoice-#{@invoice_2.id}") do
          expect(page).to have_content("#{@invoice_2.id}")
          expect(page).to have_content("#{@invoice_2.created_at.strftime("%A, %B %d, %Y")}")
        end
      end
    end

    it 'each incomplete invoice is a link to that invoices show page' do
      within("#incomplete_invoice-#{@invoice_4.id}") do
        expect(page).to have_content("#{@invoice_4.created_at.strftime("%A, %B %d, %Y")}")
        expect(page).to have_link("#{@invoice_4.id}")
        click_link("#{@invoice_4.id}")
        expect(current_path).to eq("/admin/invoices/#{@invoice_4.id}")
      end

      visit admin_dashboard_index_path

      within("#incomplete_invoice-#{@invoice_2.id}") do
        expect(page).to have_content("#{@invoice_2.created_at.strftime("%A, %B %d, %Y")}")
        expect(page).to have_link("#{@invoice_2.id}")
        click_link("#{@invoice_2.id}")
        expect(current_path).to eq("/admin/invoices/#{@invoice_2.id}")
      end
    end
  end
end
