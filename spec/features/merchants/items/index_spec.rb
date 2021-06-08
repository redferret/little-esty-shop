require 'rails_helper'

RSpec.describe 'The index page for an merchants items,' do

  before :all do
    @merchant_1 = FactoryBot.create(:merchant)
    @item_1 = FactoryBot.create(:item, merchant: @merchant_1)
    item_2 = FactoryBot.create(:item, merchant: @merchant_1)
    item_3 = FactoryBot.create(:item, merchant: @merchant_1)

  end

  before :each do
    visit merchant_items_path(@merchant_1)
  end

  it 'has a link to create a new item' do
    within '#page-links' do
      expect(page).to have_link('Add New Item')
    end
  end

  describe 'list of items,' do
    it 'shows only the merchants items' do
      merchant_2 = FactoryBot.create(:merchant)
      item_4 = FactoryBot.create(:item, merchant: merchant_2, name: 'Impossible Name To Be Random')

      @merchant_1.items.each do |item|
        within "#item-#{item.id}" do
          expect(page).to have_link(item.name)
          expect(page).to have_content("$#{item.convert_unit_price_to_dollars}")
        end
        within "#item-#{item.id}" do
          expect(page).to have_content(item.description)
        end
      end

      within '#item-list' do
        expect(page).to_not have_content(item_4.name)
      end
    end

    describe 'link to an item show page,' do
      it 'navigates to the show page for that item' do
        within "#item-#{@item_1.id}" do
          click_link @item_1.name
        end

        expect(current_path).to eq merchant_item_path(@merchant_1, @item_1)
      end
    end

    describe 'top 5 items' do
      it 'shows the top 5 items that a merchant sells' do
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

        visit merchant_items_path(merchant)

        within "#top-items" do
          expect(page).to have_content(item_1.name)
          expect(page).to have_content(item_3.name)
          expect(page).to have_content(item_4.name)
          expect(page).to have_content(item_5.name)
          expect(page).to have_content(item_6.name)
          expect(page).to_not have_content(item_2.name)
          expect(page).to_not have_content(item_7.name)
        end
      end
    end
  end
end
