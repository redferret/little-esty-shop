require 'rails_helper'

RSpec.describe 'The merchants index page,' do
  before :all do
    @merchant_1 = FactoryBot.create(:merchant)
    @merchant_2 = FactoryBot.create(:merchant)
    @merchant_3 = FactoryBot.create(:merchant, enabled: false, name: 'Disabled 1')
    @merchant_4 = FactoryBot.create(:merchant, enabled: false, name: 'Disabled 2')
  end

  before :each do
    visit admin_merchants_path
  end

  describe 'enable/diable link,' do
    describe 'enable merchant,' do
      it 'enables merchant and redirects to the admin merchants index'
    end

    describe 'disable merchant,' do
      it 'enables merchant and redirects to the admin merchants index'
    end
  end
  

  describe 'enabled merchants list,' do
    it 'shows all the merchants that are enabled' do
      within '#enabled-merchants' do
        expect(page).to have_content('Enabled Merchants')

        expect(page).to_not have_link(@merchant_3.name)
        expect(page).to_not have_link(@merchant_4.name)
        
        within "#merchant-#{@merchant_1.id}" do
          expect(page).to have_link(@merchant_1.name)
          expect(page).to have_link('Disable')
        end
        
        within "#merchant-#{@merchant_2.id}" do
          expect(page).to have_link(@merchant_2.name)
          expect(page).to have_link('Disable')
        end
      end
    end
  end
  
  describe 'disabled merchants list,' do
    it 'shows all the merchants that are disabled' do
      within '#disabled-merchants' do
        expect(page).to have_content('Disabled Merchants')
    
        expect(page).to_not have_link(@merchant_1.name)
        expect(page).to_not have_link(@merchant_2.name)
        
        within "#merchant-#{@merchant_3.id}" do
          expect(page).to have_link(@merchant_3.name)
          expect(page).to have_link('Disable')
        end
        
        within "#merchant-#{@merchant_4.id}" do
          expect(page).to have_link(@merchant_4.name)
          expect(page).to have_link('Disable')
        end
      end
    end
  end
end
