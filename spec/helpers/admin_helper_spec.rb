require 'rails_helper'

RSpec.describe AdminHelper do
  before :each do
    @merchant = FactoryBot.create(:merchant)
  end
  describe '::enable_disable_merchant_link' do
    it 'returns a link to enable a merchant' do
      expect(enable_disable_merchant_link('enable', @merchant)).to have_link('Enable', href: admin_merchant_path(@merchant, enabled: true))
    end
    it 'returns a link to disable a merchant' do
      expect(enable_disable_merchant_link('disable', @merchant)).to have_link('Disable', href: admin_merchant_path(@merchant, enabled: false))
    end
  end
end
