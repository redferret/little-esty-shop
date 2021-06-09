require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :description }
  end

  describe 'relationships' do
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should belong_to :merchant }
  end

  describe 'instance method,' do
    before :each do
      @item = Item.new
      @item.errors.add(:name)
      @item.errors.add(:unit_price)
    end

    describe '#has_errors?' do
      it 'returns true if the model has errors' do
        expect(@item.has_errors?).to eq true
      end

      it 'returns false if the model has no errors' do
        merchant = FactoryBot.create(:merchant)
        item = FactoryBot.create(:item, merchant: merchant)

        expect(item.has_errors?).to eq false
      end
    end

    describe '#humanize_errors' do
      it 'returns a string with all the errors appened' do
        expect(@item.humanize_errors).to eq "Error(s), Name is invalid, Unit price is invalid"
      end
    end
  end


  describe '#most_popular_items' do
    it 'returns the 5 most popular items for a merchant' do
      merchant = FactoryBot.create(:merchant)
      merchant_2 = FactoryBot.create(:merchant)

      item_1 = FactoryBot.create(:item, merchant: merchant, unit_price: 1000)
      item_2 = FactoryBot.create(:item, merchant: merchant, unit_price: 1200)
      item_3 = FactoryBot.create(:item, merchant: merchant, unit_price: 500)
      item_4 = FactoryBot.create(:item, merchant: merchant, unit_price: 300)
      item_5 = FactoryBot.create(:item, merchant: merchant, unit_price: 3000)
      item_6 = FactoryBot.create(:item, merchant: merchant, unit_price: 2000)
      item_7 = FactoryBot.create(:item, merchant: merchant_2, unit_price: 2000)

      customer = FactoryBot.create(:customer)

      invoice_1 = Invoice.create!(status: "in_progress", customer: customer)
      invoice_2 = Invoice.create!(status: "in_progress", customer: customer)

      invoice_item_1 = FactoryBot.create(:invoice_item, item: item_1, invoice: invoice_1, unit_price: 1000, quantity: 4)
      invoice_item_2 = FactoryBot.create(:invoice_item, item: item_2, invoice: invoice_1, unit_price: 1200, quantity: 1)
      invoice_item_3 = FactoryBot.create(:invoice_item, item: item_3, invoice: invoice_1, unit_price: 500, quantity: 4)
      invoice_item_4 = FactoryBot.create(:invoice_item, item: item_4, invoice: invoice_1, unit_price: 300, quantity: 5)
      invoice_item_5 = FactoryBot.create(:invoice_item, item: item_5, invoice: invoice_1, unit_price: 3000, quantity: 6)
      invoice_item_6 = FactoryBot.create(:invoice_item, item: item_6, invoice: invoice_1, unit_price: 2000, quantity: 10)
      invoice_item_7 = FactoryBot.create(:invoice_item, item: item_7, invoice: invoice_2, unit_price: 2000, quantity: 20)

      invoice_items = merchant.invoice_items
      expect(Item.top_5_items(merchant.id)).to eq([item_6, item_5, item_1, item_3, item_4])
    end
  end
end
