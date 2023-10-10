require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe "#total" do
    let(:product) do
      create(:product, price: 10.0)
    end
    let(:cart) do
      create(:cart) do |cart|
        create(:cart_item, cart: cart, product: product, quantity: 2)
      end
    end

    it do
      expect(cart.total).to eq(20)
    end
  end
end
