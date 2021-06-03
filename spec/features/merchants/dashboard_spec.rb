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

    it 'has link to merchant invoices index' do

    expect(page).to have_link('Merchant Invoices Index')
    click_on('Merchant Invoices Index')
    expect(current_path).to eq(merchant_invoices_path(@merchant_1))
  end
end