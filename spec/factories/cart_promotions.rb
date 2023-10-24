FactoryBot.define do
  factory :cart_promotion do
    cart { nil }
    promotion { nil }
    value { 1.5 }
  end
end
