require 'rails_helper'

RSpec.describe 'Admin Merchants Edit Page' do
  before :each do
    @merchant_1 = FactoryBot.create(:merchant)
  end

  describe 'as an admin' do
    it "loads prepopulated form with merchant's info" do
      visit edit_admin_merchant_path(@merchant_1)

      within('form') do
        fill_in('merchant[name]', with: 'Fanzy Petz')
        click_on 'Submit'
      end
      expect(current_path).to eq(admin_merchant_path(@merchant_1))
    end

    it 'shows flash message if fields are saved blank' do
      visit edit_admin_merchant_path(@merchant_1)

      within('form') do
        fill_in('merchant[name]', with: 'Fanzy Petz')
        click_on 'Submit'
      end

      expect(current_path).to eq(admin_merchant_path(@merchant_1))
      within '#flash-message' do
        expect(page).to have_content('Merchant Successfully Updated')
      end
    end
  end
end
