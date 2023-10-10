require 'rails_helper'

RSpec.describe CartItem, type: :model do
  describe "#subtotal" do
    let(:product) do
      create(:product, price: 10.0)
    end
    let(:cart_item) do
      create(:cart_item,
             cart: create(:cart),
             product: product,
             quantity: 2)
    end

    it do
      expect(cart_item.subtotal).to eq(20)
    end
  end
end
