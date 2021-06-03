class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
end
