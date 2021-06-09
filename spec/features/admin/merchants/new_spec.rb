require 'rails_helper'

RSpec.describe 'The merchants index page,' do

  before :all do
    @merchant_1 = FactoryBot.create(:merchant)
  end

  describe 'Create new merchant as Admin,' do
    it 'loads form to create a new merchant' do
      visit new_admin_merchant_path

      within '#form' do
        fill_in('merchant_name', with: 'Fancy Petz')
        click_on('Submit')
      end

      expect(current_path).to eq(admin_merchants_path)

      within '#disabled-merchants' do
        expect(page).to have_content('Fancy Petz')
      end
    end
  end
end
