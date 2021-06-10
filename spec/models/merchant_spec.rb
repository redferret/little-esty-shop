require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :items }
  end

  describe 'validations' do
  end

  describe 'class method,' do
    before :all do
      @merchant_1 = FactoryBot.create(:merchant)
      @merchant_2 = FactoryBot.create(:merchant, enabled: false)
    end
    describe '::enabled_merchants' do
      it 'returns a list of merchants that are enabled' do
        expect(Merchant.enabled_merchants).to eq [@merchant_1]
      end
    end

    describe '::disabled_merchants' do
      it 'returns a list of merchants that are disabled' do
        expect(Merchant.disabled_merchants).to eq [@merchant_2]
      end
    end

    describe '#top_merchants' do
      it 'returns the top 5 merchants by total revenue' do
        merchant_1 = FactoryBot.create(:merchant)
        merchant_2 = FactoryBot.create(:merchant)
        merchant_3 = FactoryBot.create(:merchant, enabled: false, name: 'Disabled 1')
        merchant_4 = FactoryBot.create(:merchant, enabled: false, name: 'Disabled 2')
        merchant_5 = FactoryBot.create(:merchant, enabled: false, name: 'Disabled 3')
        merchant_6 = FactoryBot.create(:merchant)

        item_1 = FactoryBot.create(:item, merchant: merchant_1, unit_price: 1000)
        item_2 = FactoryBot.create(:item, merchant: merchant_2, unit_price: 1200)
        item_3 = FactoryBot.create(:item, merchant: merchant_3, unit_price: 500)
        item_4 = FactoryBot.create(:item, merchant: merchant_4, unit_price: 300)
        item_5 = FactoryBot.create(:item, merchant: merchant_5, unit_price: 3000)
        item_6 = FactoryBot.create(:item, merchant: merchant_6, unit_price: 2000)

        customer = FactoryBot.create(:customer)

        invoice_1 = Invoice.create!(status: "in_progress", customer: customer)

        invoice_item_1 = FactoryBot.create(:invoice_item, item: item_1, invoice: invoice_1, unit_price: 1000, quantity: 1)
        invoice_item_2 = FactoryBot.create(:invoice_item, item: item_2, invoice: invoice_1, unit_price: 1200, quantity: 1)
        invoice_item_3 = FactoryBot.create(:invoice_item, item: item_3, invoice: invoice_1, unit_price: 500, quantity: 1)
        invoice_item_4 = FactoryBot.create(:invoice_item, item: item_4, invoice: invoice_1, unit_price: 300, quantity: 1)
        invoice_item_5 = FactoryBot.create(:invoice_item, item: item_5, invoice: invoice_1, unit_price: 3000, quantity: 1)
        invoice_item_6 = FactoryBot.create(:invoice_item, item: item_6, invoice: invoice_1, unit_price: 2000, quantity: 1)

        expect(Merchant.top_merchants).to eq([merchant_5, merchant_6, merchant_2, merchant_1, merchant_3])
      end
    end
  end
end