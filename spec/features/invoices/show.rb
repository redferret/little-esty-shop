require 'rails_helper'

RSpec.describe 'show' do
  before(:each) do
    # @merchant = FactoryBot.create(:merchant)
    # @item_1 = FactoryBot.create(:item, merchant: @merchant)
    # @item_2 = FactoryBot.create(:item, merchant: @merchant)
    # @item_3 = FactoryBot.create(:item, merchant: @merchant)
    # @customer = FactoryBot.create(:customer)
    # @invoice_1 = FactoryBot.create(:invoice, customer: @customer)
    # @invoice_2 = FactoryBot.create(:invoice, customer: @customer)
    # @invoice_item = FactoryBot.create(:invoice_item, item: @item_1, invoice: @invoice_1)

    @merchant = FactoryBot.create(:merchant)
    @item_1 = FactoryBot.create(:item, merchant: @merchant)
    @item_2 = FactoryBot.create(:item, merchant: @merchant)
    @item_3 = FactoryBot.create(:item, merchant: @merchant)
    @customer = Customer.create!(first_name: "Dean", last_name: "Winchester")
    @invoice_1 = Invoice.create!(status: "in_progress", customer: @customer)
    @invoice_item = FactoryBot.create(:invoice_item, item: @item_1, invoice: @invoice_1)

    visit "/merchants/#{@merchant.id}/invoices/#{@invoice_1.id}"
  end

    # As a merchant
    # When I visit my merchant invoice show page
    # Then I see all of my items on the invoice including:

    # Item name
    # The quantity of the item ordered
    # The price the Item sold for
    # The Invoice Item status
    # And I do not see any information related to Items for other merchants

  it 'shows all the invoices with their attributes' do

    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@invoice_item.quantity)
    expect(page).to have_content(@invoice_item.price)
    expect(page).to have_content(@invoice_1.status)
  end

    # As a merchant
    # When I visit my merchant invoice show page
    # I see that each invoice item status is a select field
    # And I see that the invoice item's current status is selected
    # When I click this select field,
    # Then I can select a new status for the Item,
    # And next to the select field I see a button to "Update Item Status"
    # When I click this button
    # I am taken back to the merchant invoice show page
    # And I see that my Item's status has now been updated

  it 'can update a invoice status' do
    expect(page).to have_content(@invoice_item.status)
  end
end