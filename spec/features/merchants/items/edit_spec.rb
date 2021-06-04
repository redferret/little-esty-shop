require 'rails_helper'

RSpec.describe 'The edit page for an item,' do
  before :all do
    @merchant = FactoryBot.create(:merchant)
    @item = FactoryBot.create(:item, merchant: @merchant)
  end

  before :each do
    visit edit_merchant_item_path(@merchant, @item)
  end

  describe 'form,' do
    it 'has a form with pre populated attributes of the item' do
      within 'form' do
        expect(page).to have_field('item[name]', with: @item.name)
        expect(page).to have_field('item[description]', with: @item.description)
        expect(page).to have_field('item[unit_price]', with: @item.unit_price)
        expect(page).to have_button('Update Item')
      end
    end
  end

  describe 'the submit button on form,' do
    it 'navigates back to the item show page with a flash message on the top saying it was added' do
      new_name = Faker::Commerce.product_name
      within 'form' do
        fill_in 'item[name]', with: new_name
        click_button 'Update Item'
      end

      expect(current_path).to eq merchant_item_path(@merchant, @item)
      
      within '#item-table' do
        expect(page).to have_content(new_name)
      end
    end

    it 'navigates back to the item show page with a flash message on the top alerting there was an error' do
      within 'form' do
        fill_in 'item[name]', with: ''
        click_button 'Update Item'
      end

      expect(current_path).to eq edit_merchant_item_path(@merchant, @item)
      
      within '#flash-message' do
        expect(page).to have_content("Item not updated - Error(s), Name can't be blank")
      end
    end
  end
end
