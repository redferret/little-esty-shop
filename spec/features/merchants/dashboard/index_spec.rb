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

  describe 'favorite customers,' do
    it 'displays the names of the top 5 customers' do
      @customer_1 = FactoryBot.create(:customer) ##
      @customer_2 = FactoryBot.create(:customer)
      @customer_3 = FactoryBot.create(:customer)
      @customer_4 = FactoryBot.create(:customer)
      @customer_5 = FactoryBot.create(:customer)
      @customer_6 = FactoryBot.create(:customer) ##

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

      within('#favorite-customers') do
        expect(page).to have_content("Favorite Customers: Top 5")
        save_and_open_page
        within("#customers-#{@customer_2.id}") do
          expect(page).to have_content(@customer_2.first_name)
          expect(page).to have_content(@customer_2.last_name)
          expect(page).to have_content(@customer_2.transactions.success_count)
        end

        within("#customers-#{@customer_3.id}") do
          expect(page).to have_content(@customer_3.first_name)
          expect(page).to have_content(@customer_3.last_name)
          expect(page).to have_content(@customer_3.transactions.success_count)
        end

        within("#customers-#{@customer_4.id}") do
          expect(page).to have_content(@customer_4.first_name)
          expect(page).to have_content(@customer_4.last_name)
          expect(page).to have_content(@customer_4.transactions.success_count)
        end
      end
    end
  end
end

# As a merchant,
# When I visit my merchant dashboard
# Then I see the names of the top 5 customers
# who have conducted the largest number of successful transactions with my merchant
# And next to each customer name I see the num:transaction,
