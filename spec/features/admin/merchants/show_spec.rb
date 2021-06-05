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
  end
end
# As an admin,
# When I visit a merchant's admin show page
# Then I see a link to update the merchant's information.
# When I click the link
# Then I am taken to a page to edit this merchant
# And I see a form filled in with the existing merchant attribute information
# When I update the information in the form and I click ‘submit’
# Then I am redirected back to the merchant's admin show page where I see the updated information
# And I see a flash message stating that the information has been successfully updated.
