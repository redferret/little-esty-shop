FactoryBot.define do
  factory :item do
    description { Faker::Lorem.sentence }
    unit_price { rand(100..5000) }
    name { Faker::Commerce.product_name }
  end
end
