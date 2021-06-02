require 'rails_helper'

RSpec.describe 'index' do
  before(:each) do
    @merchant = FactoryBot.create(:merchant)
    @item_1 = FactoryBot.create(:item, merchant: @merchant)
    @item_2 = FactoryBot.create(:item, merchant: @merchant)
    @item_3 = FactoryBot.create(:item, merchant: @merchant)
    @customer = FactoryBot.create(:customer)
    @invoice_1 = FactoryBot.create(:invoice, customer: @customer)
    @invoice_2 = FactoryBot.create(:invoice, customer: @customer)
    @invoice_item = FactoryBot.create(:invoice_item, item: @item_1, invoice: @invoice_1)
  end

  it 'shows all the invoices with at least one of the merchants items' do
  end
end