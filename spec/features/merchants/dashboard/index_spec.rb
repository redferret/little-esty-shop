require 'rails_helper'

RSpec.describe "dashboard" do
  before(:each) do
    @merchant_1 = FactoryBot.create(:merchant)
    @item_1 = FactoryBot.create(:item, merchant: @merchant_1)
    @item_2 = FactoryBot.create(:item, merchant: @merchant_1)
    @item_3 = FactoryBot.create(:item, merchant: @merchant_1)
    @customer = FactoryBot.create(:customer)
    @invoice_1 = FactoryBot.create(:invoice, customer: @customer)
    @invoice_2 = FactoryBot.create(:invoice, customer: @customer)
    @invoice_3 = FactoryBot.create(:invoice, customer: @customer)
    @invoice_item_1 = FactoryBot.create(:invoice_item, item: @item_1, invoice: @invoice_1, status: 'pending')
    @invoice_item_2 = FactoryBot.create(:invoice_item, item: @item_2, invoice: @invoice_2, status: 'packaged')
    @invoice_item_3 = FactoryBot.create(:invoice_item, item: @item_3, invoice: @invoice_3, status: 'shipped')

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

  it "displays a ready to ship section" do

    within('section#ready-to-ship') do
      save_and_open_page
      expect(page).to have_content("Items Ready to Ship")
    end
  end

  it "it lists names of ordered items not yet shipped" do

    within('section#ready-to-ship') do
      # require "pry"; binding.pry
      expect(page).to have_content(@invoice_item_1.item.name)
      expect(page).to have_content(@invoice_item_2.item.name)
      expect(page).to_not have_content(@invoice_item_3.item.name)
    end
  end

  it "it lists each invoice id as a link next to item name" do

    within('section#ready-to-ship') do
      expect(page).to have_link("Invoice ID #{@item_1.invoice_id}")
      expect(page).to have_content("Invoice ID #{@item_2.invoice_id}")
      expect(page).to_not have_content("Invoice ID #{@item_3.invoice_id}")
    end
  end

  it "it displays the invoice creation date ordered from oldest to newest" do

    within('section#ready-to-ship') do
      expect(page).to have_content(@invoice_1.invoice_creation_date)
      # expect(SOME_INVOICE.invoice_creation_date).to appear_before(SOME_OTHER_INVOICE.invoice_creation_date)
      expect(page).to have_content(@item_2.name)
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
