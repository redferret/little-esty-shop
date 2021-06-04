require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :unit_price }
    it { should validate_presence_of :description }
  end

  describe 'relationships' do
    it { should have_many :invoice_items }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should belong_to :merchant }
  end

  describe 'instance method,' do
    before :each do
      @item = Item.new
      @item.errors.add(:name)
      @item.errors.add(:unit_price)
    end

    describe '#has_errors?' do
      it 'returns true if the model has errors' do
        expect(@item.has_errors?).to eq true
      end
      
      it 'returns false if the model has no errors' do
        merchant = FactoryBot.create(:merchant)
        item = FactoryBot.create(:item, merchant: merchant)

        expect(item.has_errors?).to eq false
      end
    end

    describe '#humanize_errors' do
      it 'returns a string with all the errors appened' do
        expect(@item.humanize_errors).to eq "Error(s), Name is invalid, Unit price is invalid"
      end
    end
  end
end
