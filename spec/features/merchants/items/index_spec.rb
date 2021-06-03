require 'rails_helper'

RSpec.describe 'The index page for an merchants items,' do

  before :all do
    @merchant_1 = FactoryBot.create(:merchant)
    item_1 = FactoryBot.create(:item, merchant: @merchant_1)
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