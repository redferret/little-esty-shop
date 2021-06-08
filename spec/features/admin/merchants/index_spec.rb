require 'rails_helper'

RSpec.describe 'The merchants index page,' do

  before :all do
    @merchant_1 = FactoryBot.create(:merchant)
    @merchant_2 = FactoryBot.create(:merchant)
    @merchant_3 = FactoryBot.create(:merchant, enabled: false, name: 'Disabled 1')
    @merchant_4 = FactoryBot.create(:merchant, enabled: false, name: 'Disabled 2')
    @merchant_5 = FactoryBot.create(:merchant, enabled: false, name: 'Disabled 3')
    @merchant_6 = FactoryBot.create(:merchant)

    @item_1 = FactoryBot.create(:item, merchant: @merchant_1, unit_price: 1000)
    @item_2 = FactoryBot.create(:item, merchant: @merchant_2, unit_price: 1200)
    @item_3 = FactoryBot.create(:item, merchant: @merchant_3, unit_price: 500)
    @item_4 = FactoryBot.create(:item, merchant: @merchant_4, unit_price: 300)
    @item_5 = FactoryBot.create(:item, merchant: @merchant_5, unit_price: 3000)
    @item_6 = FactoryBot.create(:item, merchant: @merchant_6, unit_price: 2000)

    @customer = FactoryBot.create(:customer)

    @invoice_1 = Invoice.create!(status: "in_progress", customer: @customer)

    @invoice_item_1 = FactoryBot.create(:invoice_item, item: @item_1, invoice: @invoice_1, unit_price: 1000, quantity: 1)
    @invoice_item_2 = FactoryBot.create(:invoice_item, item: @item_2, invoice: @invoice_1, unit_price: 1200, quantity: 1)
    @invoice_item_3 = FactoryBot.create(:invoice_item, item: @item_3, invoice: @invoice_1, unit_price: 500, quantity: 1)
    @invoice_item_4 = FactoryBot.create(:invoice_item, item: @item_4, invoice: @invoice_1, unit_price: 300, quantity: 1)
    @invoice_item_5 = FactoryBot.create(:invoice_item, item: @item_5, invoice: @invoice_1, unit_price: 3000, quantity: 1)
    @invoice_item_6 = FactoryBot.create(:invoice_item, item: @item_6, invoice: @invoice_1, unit_price: 2000, quantity: 1)
  end

  before :each do
    visit admin_merchants_path
  end

  describe 'enable/diable link,' do
    describe 'enable merchant,' do
      it 'enables merchant and redirects to the admin merchants index' do
        within '#disabled-merchants' do
          within "#merchant-#{@merchant_5.id}" do
            click_link 'Enable'
          end
        end

        expect(current_path).to eq admin_merchants_path

        within '#enabled-merchants' do
          within "#merchant-#{@merchant_5.id}" do
            expect(page).to have_link(@merchant_5.name)
          end
        end
      end
    end

    describe 'disable merchant,' do
      it 'disables merchant and redirects to the admin merchants index' do
        within '#enabled-merchants' do
          within "#merchant-#{@merchant_6.id}" do
            click_link 'Disable'
          end
        end

        expect(current_path).to eq admin_merchants_path

        within '#disabled-merchants' do
          within "#merchant-#{@merchant_6.id}" do
            expect(page).to have_link(@merchant_6.name)
          end
        end
      end
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
          expect(page).to have_link('Enable')
        end

        within "#merchant-#{@merchant_4.id}" do
          expect(page).to have_link(@merchant_4.name)
          expect(page).to have_link('Enable')
        end
      end
    end
  end

  describe 'top 5 merchants by revenue' do
    it 'shows the top 5 merchants by revenue' do
      save_and_open_page
      within "#top-merchants" do
        expect(page).to have_content(@merchant_1.name)
        expect(page).to have_content(@merchant_2.name)
        expect(page).to have_content(@merchant_3.name)
        expect(page).to have_content(@merchant_5.name)
        expect(page).to have_content(@merchant_6.name)
        expect(page).to_not have_content(@merchant_4.name)
      end
    end
  end
end
