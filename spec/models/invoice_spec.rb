require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'relationships' do
    it { should have_many :invoice_items }
    it { should have_many :transactions }
    it { should have_many(:items).through(:invoice_items) }
    it { should belong_to :customer }
  end

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

  describe 'class methods' do
    describe "#incomplete_oldest_first" do
      it "returns all incomplete invoices ordered old to new" do
        expect(Invoice.incomplete_oldest_first).to eq([@invoice_4, @invoice_2, @invoice_1])
      end
    end
  end
end
