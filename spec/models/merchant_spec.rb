require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it { should have_many :items }
    it { should have_many(:customers).through(:invoices) }
  end

  describe 'validations' do
  end

  describe 'class method,' do
    before :all do
      @merchant_1 = FactoryBot.create(:merchant)
      @merchant_2 = FactoryBot.create(:merchant, enabled: false)
    end
    describe '::enabled_merchants' do
      it 'returns a list of merchants that are enabled' do
        expect(Merchant.enabled_merchants).to eq [@merchant_1]
      end
    end

    describe '::disabled_merchants' do
      it 'returns a list of merchants that are disabled' do
        expect(Merchant.disabled_merchants).to eq [@merchant_2]
      end
    end
  end

end
