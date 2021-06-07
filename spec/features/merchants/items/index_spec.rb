require 'rails_helper'

RSpec.describe 'The index page for an merchants items,' do

  before :all do
    @merchant_1 = FactoryBot.create(:merchant)
    @item_1 = FactoryBot.create(:item, merchant: @merchant_1)
    @item_2 = FactoryBot.create(:item, merchant: @merchant_1)
    @item_3 = FactoryBot.create(:item, merchant: @merchant_1)

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

    describe 'enalbed/disabled sections,' do
      it 'has sections for enabled and disabled items' do
        within '#enabled-items' do
          expect(page).to have_content('Enabled Items')
        end

        within '#disabled-items' do
          save_and_open_page
          expect(page).to have_content('Disabled Items')
        end
      end
    end
  end
end

#ALICIA :) I was going to try to do a test like below but as you know i struggle with the studid within blocks
# * an unrealted note: in Item model - I kept getting mixed up with the enable and disable method,as far as whether status should start out as true or false

# it 'shows that enabled item can have status changed to disabled by clicking button' do
#     within(SOMETHING) do
#       expect(page).to have_button('Disable')
#
#       click_button 'Disable'
#
#       expect(current_path).to eq("/merchants/#{@merchant1.id}/items")
#
#       expect(page).to have_button('Enable')
#     end
#   end

#31
# As a merchant,
# When I visit my merchant items index page
# Then I see two sections, one for "Enabled Items" and one for "Disabled Items"
# And I see that each Item is listed in the appropriate section
#32
#As a merchant
# When I visit my items index page
# Next to each item name I see a button to disable or enable that item.
# When I click this button
# Then I am redirected back to the items index
# And I see that the items status has changed
