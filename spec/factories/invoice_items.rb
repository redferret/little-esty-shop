FactoryBot.define do
  factory :invoice_item do
    quantity { rand(1..5) }
    unit_price { rand(100..5000) }
  end
end