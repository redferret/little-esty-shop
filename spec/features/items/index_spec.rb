require 'rails_helper'

RSpec.describe 'The index page for an merchants items,' do
  describe 'list of items,' do
    it 'shows only the merchants items' do
      merchant_1 = FactoryBot.create(:merchant)
      merchant_2 = FactoryBot.create(:merchant)
      item_1 = FactoryBot.create(:item, merchant: merchant_1)
      item_2 = FactoryBot.create(:item, merchant: merchant_1)
      item_3 = FactoryBot.create(:item, merchant: merchant_1)
      item_4 = FactoryBot.create(:item, merchant: merchant_2, name: 'Impossible Name To Be Random')

      visit merchant_items_path(merchant_1)

      merchant_1.items.each do |item|
        within "#item-#{item.id}" do
          expect(page).to have_content(item.name)
          expect(page).to have_content(item.unit_price)
        end
        within "#item-#{item.id}-description" do
          expect(page).to have_content(item.description)
        end
      end

      within '#item-list' do
        expect(page).to_not have_content(item_4.name)
      end
    end
  end
  
end
