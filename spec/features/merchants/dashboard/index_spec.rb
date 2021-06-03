require 'rails_helper'

RSpec.describe "dashboard" do
  before(:each) do
    @merchant_1 = FactoryBot.create(:merchant)
    @item_1 = FactoryBot.create(:item, merchant: @merchant_1)
    @item_2 = FactoryBot.create(:item, merchant: @merchant_1)
    @item_3 = FactoryBot.create(:item, merchant: @merchant_1)
    @item_4 = FactoryBot.create(:item, merchant: @merchant_1)
    @customer = FactoryBot.create(:customer)
    @invoice_1 = FactoryBot.create(:invoice, customer: @customer)
    @invoice_2 = FactoryBot.create(:invoice, customer: @customer)
    @invoice_3 = FactoryBot.create(:invoice, customer: @customer)
    @invoice_4 = FactoryBot.create(:invoice, customer: @customer)
    @invoice_item_1 = FactoryBot.create(:invoice_item, item: @item_1, invoice: @invoice_1, status: 'pending')
    @invoice_item_2 = FactoryBot.create(:invoice_item, item: @item_2, invoice: @invoice_2, status: 'packaged')
    @invoice_item_3 = FactoryBot.create(:invoice_item, item: @item_3, invoice: @invoice_3, status: 'shipped')
    @invoice_item_4 = FactoryBot.create(:invoice_item, item: @item_4, invoice: @invoice_4, status: 'packaged')

    visit merchant_dashboard_index_path(@merchant_1)
  end

  it 'has merchant name' do
    expect(page).to have_content(@merchant_1.name)
  end

  it 'has link to merchant items index' do
    expect(page).to have_link('Merchant Items Index')
    click_on('Merchant Items Index')
    expect(current_path).to eq(merchant_items_path(@merchant_1))
  end

  it 'has link to merchant invoices index' do
    expect(page).to have_link('Merchant Invoices Index')
    click_on('Merchant Invoices Index')
    expect(current_path).to eq(merchant_invoices_path(@merchant_1))
  end

  describe 'the list of ready-to-ship items,' do
    it "displays a ready to ship section" do
      within('#ready-to-ship') do
        expect(page).to have_content("Items Ready to Ship")
      end
    end

    it "it lists each invoice id as a link to the invoice" do
      within("#invoice-item-#{@invoice_item_2.id}") do
        expect(page).to have_link("Invoice ##{@invoice_2.id}")
      end
      within("#invoice-item-#{@invoice_item_4.id}") do
        expect(page).to have_link("Invoice ##{@invoice_4.id}")
      end
    end

    it "it lists names of ordered items" do
      within("#invoice-item-#{@invoice_item_2.id}") do
        expect(page).to have_content(@item_2.name)
      end
      within("#invoice-item-#{@invoice_item_4.id}") do
        expect(page).to have_content(@item_4.name)
      end
    end

    it "it displays the invoice creation date ordered from oldest to newest" do
      within('#ready-to-ship') do
        expect(find("#invoice-item-#{@invoice_item_2.id}")).to appear_before(find("#invoice-item-#{@invoice_item_4.id}"))
      end
    end
  end
end

# Merchant Dashboard Items Ready to Ship

# As a merchant
# When I visit my merchant dashboard
# Then I see a section for "Items Ready to Ship"
# # In that section I see a list of the names of all of my items that
# # have been ordered and have not yet been shipped,
# # And next to each Item I see the id of the invoice that ordered my item
# # And each invoice id is a link to my merchant's invoice show page

# As a merchant
# When I visit my merchant dashboard
# In the section for "Items Ready to Ship",
# Next to each Item name I see the date that the invoice was created
# And I see the date formatted like "Monday, July 18, 2019"
# And I see that the list is ordered from oldest to newest
