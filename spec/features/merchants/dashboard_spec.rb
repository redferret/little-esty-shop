require 'rails_helper'

RSpec.describe "dashboard" do
  before(:each) do
    @merchant_1 = FactoryBot.create(:merchant)

    visit dashboard_merchant_path(@merchant_1)
  end

  it 'has merchant name' do
    expect(page).to have_content(@merchant_1.name)
  end

  it 'has link to merchant items index' do

    expect(page).to have_link('Merchant Items Index')
    click_on('Merchant Items Index')
    expect(current_path).to eq(merchant_items_path(@merchant_1))
  end

    it 'has link to merchant items index' do

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
    @item_1 = FactoryBot.create(:item, merchant_id: @merchant_1.id)
    @item_2 = FactoryBot.create(:item, merchant_id: @merchant_1.id)
    @item_3 = FactoryBot.create(:item, merchant_id: @merchant_1.id)
    # @customer_1 = FactoryBot.create(:customer)
    # @invoice_1 = FactoryBot.create(:invoice, customer: @customer_1)
    @customer = Customer.create!(first_name: "Dean", last_name: "Winchester")
    @invoice_1 = Invoice.create!(status: "in_progress", customer: @customer)
    @invoice_item_1 = FactoryBot.create(:invoice_item, item: @item_1, invoice: @invoice_1, status: :pending)
    # @invoice_item_2 = FactoryBot.create(:invoice_item, item: @item_2, item_status: :package)
    # @invoice_item_3 = FactoryBot.create(:invoice_item, item: @item_3, item_status: :shipped)
    # @item_4 = FactoryBot.create(:item)

    within('section#ready-to-ship') do


      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_2.name)

      expect(page).to_not have_content(@item_3.name)
      expect(page).to_not have_content(@item_4.name)
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
