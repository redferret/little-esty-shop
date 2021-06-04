require 'rails_helper'

RSpec.describe "The new item page" do
  before :all do
    @merchant = FactoryBot.create(:merchant)
  end

  before :each do
    visit new_merchant_item_path(@merchant)
  end

  describe 'form,' do
    it 'has fields to enter item information' do
      within '#new-item-form' do
        expect(page).to have_field('item[name]')
        expect(page).to have_field('item[unit_price]')
        expect(page).to have_field('item[description]')
      end
    end
    
    describe 'submit,' do
      it 'redirects back to the merchant items index page when a new item is created' do
        new_name = Faker::Commerce.product_name

        within '#new-item-form' do
          fill_in 'item[name]', with: new_name
          fill_in 'item[unit_price]', with: rand(100..5000)
          fill_in 'item[description]', with: Faker::Lorem.sentence
          click_button 'Add Item'
        end

        expect(current_path).to eq merchant_items_path(@merchant)

        within '#item-list' do
          expect(page).to have_content(new_name)
        end
      end
    end
  end
end
