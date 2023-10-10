require 'rails_helper'

RSpec.describe CartItemsController, type: :controller do
  let(:product) { create(:product) }

  describe "POST create" do
    subject(:post_request) do
      post(:create,
           params: { cart_item: { product_id: product.id, quantity: 1 } }
      )
    end

    it "creates a cart_item" do
      expect { post_request }.to change(CartItem, :count).by(+1)
    end
  end

  describe "PUT update" do
    let(:cart) { create(:cart) }
    let(:cart_item) { create(:cart_item, cart: cart, product_id: product.id, quantity: 1) }

    before do
      allow_any_instance_of(ApplicationHelper).to receive(:current_cart).and_return(cart)
    end

    subject(:put_request) do
      put(:update, params: { id: cart_item.id, cart_item: { product_id: product.id, quantity: 2 } })
    end

    it "creates a cart_item" do
      expect { put_request }.to change { cart_item.reload.quantity }.by(+1)
    end
  end
end
