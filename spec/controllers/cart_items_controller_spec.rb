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

    it "uses CartPromotionsCalculator" do
      expect(Cart::CartPromotionsCalculator).to receive(:run).with(Cart)
      post_request
    end
  end

  describe "PUT update" do
    let(:cart) { create(:cart) }
    let(:cart_item) { create(:cart_item, cart: cart, product_id: product.id, quantity: 1) }

    before do
      allow_any_instance_of(ApplicationHelper).to receive(:current_cart).and_return(cart)
    end

    subject(:put_request) do
      put(:update, params: { id: cart_item.id, cart_item: { product_id: product.id, quantity: new_quantity } })
    end

    context "when the cart_item changed" do
      let(:new_quantity) { 2 }

      it "creates a cart_item" do
        expect { put_request }.to change { cart_item.reload.quantity }.by(+1)
      end

      it "uses CartPromotionsCalculator" do
        expect(Cart::CartPromotionsCalculator).to receive(:run).with(Cart)
        put_request
      end

      it "redirects to cart_path" do
        put_request
        expect(response).to redirect_to(cart_path)
      end
    end

    context "when the cart_item did not change" do
      let(:new_quantity) { 1 }

      it "creates a cart_item" do
        expect { put_request }.not_to change { cart_item.reload.quantity }
      end

      it "uses CartPromotionsCalculator" do
        expect(Cart::CartPromotionsCalculator).not_to receive(:run).with(Cart)
        put_request
      end

      it "does not redirect to cart_path" do
        put_request
        expect(response).not_to redirect_to(cart_path)
      end
    end
  end

  describe "DELETE destroy" do
    let(:cart) { create(:cart) }
    let(:cart_item) { create(:cart_item, cart: cart, product_id: product.id, quantity: 1) }

    before do
      cart_item
      allow_any_instance_of(ApplicationHelper).to receive(:current_cart).and_return(cart)
    end

    subject(:delete_request) do
      put(:destroy, params: { id: cart_item.id, cart_item: { product_id: product.id, quantity: 1 } })
    end

    it "creates a cart_item" do
      expect { delete_request }.to change { CartItem.count }.by(-1)
    end

    it "uses CartPromotionsCalculator" do
      expect(Cart::CartPromotionsCalculator).to receive(:run).with(Cart)
      delete_request
    end

    it "redirects to cart_path" do
      delete_request
      expect(response).to redirect_to(cart_path)
    end
  end
end

