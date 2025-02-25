require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'relationships' do
    it { should belong_to :invoice }
  end

  describe 'validations' do
    it { should validate_presence_of(:credit_card_number) }
    it { should validate_numericality_of(:credit_card_number) }
    it { should validate_presence_of(:result) }
    # it { should allow_value(:failed).for(:result) }
    # it { should allow_value(:success).for(:result) }
  end
end
