require 'rails_helper'

RSpec.describe AdminHelper do
  before :each do
    @merchant = FactoryBot.create(:merchant)
  end
  describe '::enable_disable_merchant_link' do
    it 'returns a link to enable a merchant' do
      expect(enable_disable_merchant_link(true, @merchant)).to have_link('Enable', href: admin_merchant_path(@merchant, enabled: true))
    end

    it 'returns a link to disable a merchant' do
      expect(enable_disable_merchant_link(false, @merchant)).to have_link('Disable', href: admin_merchant_path(@merchant, enabled: false))
    end

    it 'returns no link if invalid string' do
      expect{enable_disable_merchant_link('foo bar', @merchant)}.to raise_error('Invalid type given')
    end
  end
end
