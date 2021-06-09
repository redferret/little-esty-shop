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
        within "#item-list" do
          within "#item-#{item.id}" do
            expect(page).to have_link(item.name)
            expect(page).to have_link('Disable')
          end
        end
      end

      within '#item-list' do
        expect(page).to_not have_content(item_4.name)
      end
    end

    describe 'link to an item show page,' do
      it 'navigates to the show page for that item' do
        within '#item-list' do
          within "#item-#{@item_1.id}" do
            click_link @item_1.name
          end
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
          expect(page).to have_content('Disabled Items')
        end
      end
    end

    describe 'enalbed/disabled buttons,' do
      it 'shows that enabled item can have status changed to disabled by clicking button' do
        within '#enabled-items' do
          within "#item-#{@item_1.id}" do
            expect(page).to have_link('Disable')
            click_link 'Disable'
            expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")
          end
        end

        within '#disabled-items' do
          within "#item-#{@item_1.id}" do
            expect(page).to have_link('Enable')
            click_link 'Enable'
            expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")
          end
        end
      end
    end
  end
end
