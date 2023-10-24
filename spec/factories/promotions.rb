FactoryBot.define do
  factory :promotion do
    product { nil }
    name { "Great Discount" }
    description { "A very good discount" }
    min_quantity { 3 }
    bulk_quantity { 1 }
    percentage { 10.0 }
  end
end
