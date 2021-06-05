require 'rails_helper'

RSpec.describe 'The show page for an item,' do
  describe 'table,' do
    before :all do
      @merchant_1 = FactoryBot.create(:merchant)
      @item = FactoryBot.create(:item, merchant: @merchant_1)
      FactoryBot.create(:item, merchant: @merchant_1)
      FactoryBot.create(:item, merchant: @merchant_1)
    end

    before :each do
      visit merchant_item_path(@merchant_1, @item)
    end

    it 'has three columns with expected headers' do
      within '#item-table' do
        expect(page).to have_content('Item Name')
        expect(page).to have_content('Unit Price')
      end
    end

    it 'shows each items name, unit price, and quantity' do
      within '#item-table' do
        expect(page).to have_content(@item.name)
        expect(page).to have_content("$#{@item.convert_unit_price_to_dollars}")
        expect(page).to have_content(@item.description)
      end
    end
  end
end
