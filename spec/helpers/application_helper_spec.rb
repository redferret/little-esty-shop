require 'rails_helper'

RSpec.describe ApplicationHelper do
  describe '::flash_class' do
    it 'returns the expected bootstrap class for each alert type' do
      expect(flash_class('notice')).to eq "class='alert alert-info'"
      expect(flash_class('success')).to eq "class='alert alert-success'"
      expect(flash_class('alert')).to eq "class='alert alert-danger'"
    end
  end
end