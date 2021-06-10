require 'rails_helper'

RSpec.describe "As an admin" do
  describe 'when I visit the admin merchants show page' do
    before :each do
      @merchant_1 = FactoryBot.create(:merchant)

      visit admin_merchant_path(@merchant_1)
    end

    it 'displays a link to update the merchant info' do

      expect(page).to have_link('Update Merchant')

      click_link('Update Merchant')

      expect(current_path).to eq(edit_admin_merchant_path(@merchant_1))
    end

    it 'displays the merchant name' do
      expect(page).to have_content(@merchant_1.name)
    end
  end
end
