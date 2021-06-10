require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many :invoices }
    it { should have_many(:merchants).through(:invoices) }
    it { should have_many(:transactions).through(:invoices)}
  end

  describe 'class methods' do
    before(:each) do
      @merchant_1 = FactoryBot.create(:merchant)

      @item_1 = FactoryBot.create(:item, merchant: @merchant_1)
      @item_2 = FactoryBot.create(:item, merchant: @merchant_1)
      @item_3 = FactoryBot.create(:item, merchant: @merchant_1)
      @item_4 = FactoryBot.create(:item, merchant: @merchant_1)

      @customer_2 = FactoryBot.create(:customer)
      @customer_3 = FactoryBot.create(:customer)
      @customer_4 = FactoryBot.create(:customer)
      @customer_5 = FactoryBot.create(:customer)
      @customer_6 = FactoryBot.create(:customer)

      @invoice_1 = FactoryBot.create(:invoice, customer: @customer_2)
      @invoice_2 = FactoryBot.create(:invoice, customer: @customer_3)
      @invoice_3 = FactoryBot.create(:invoice, customer: @customer_4)
      @invoice_4 = FactoryBot.create(:invoice, customer: @customer_5)

      @invoice_item_1 = FactoryBot.create(:invoice_item, item: @item_1, invoice: @invoice_1, status: 'pending')
      @invoice_item_2 = FactoryBot.create(:invoice_item, item: @item_2, invoice: @invoice_2, status: 'packaged')
      @invoice_item_3 = FactoryBot.create(:invoice_item, item: @item_3, invoice: @invoice_3, status: 'shipped')
      @invoice_item_4 = FactoryBot.create(:invoice_item, item: @item_4, invoice: @invoice_4, status: 'packaged')

      transaction_1 = FactoryBot.create(:transaction, result: "success", invoice_id: @invoice_1.id)
      transaction_2 = FactoryBot.create(:transaction, result: "failed", invoice_id: @invoice_2.id)
      transaction_3 = FactoryBot.create(:transaction, result: "success", invoice_id: @invoice_3.id)
      transaction_4 = FactoryBot.create(:transaction, result: "success", invoice_id: @invoice_4.id)
      transaction_5 = FactoryBot.create(:transaction, result: "success", invoice_id: @invoice_1.id)
      transaction_6 = FactoryBot.create(:transaction, result: "failed", invoice_id: @invoice_2.id)
      transaction_7 = FactoryBot.create(:transaction, result: "success", invoice_id: @invoice_3.id)
      transaction_8 = FactoryBot.create(:transaction, result: "success", invoice_id: @invoice_1.id)
    end

    describe "favorite customers" do
      it 'lists the top five customers for a merchant' do

        expect(Customer.top_five_customers.to_a).to eq([@customer_2, @customer_4, @customer_5])
        expect(Customer.top_five_customers.to_a).to_not eq([@customer_4, @customer_6])
      end
    end
  end
end
