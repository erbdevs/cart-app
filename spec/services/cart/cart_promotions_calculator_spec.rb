require 'rails_helper'

class Cart
  RSpec.describe CartPromotionsCalculator do
    describe ".run" do
      let(:product) { create(:product, name: "Product", price: 100) }
      let(:cart) { create(:cart) }

      subject(:calculation) { described_class.run(cart) }

      context "when there are no discounts for the cart_item" do
        before do
          create(:cart_item, cart: cart, product_id: product.id, quantity: 3)
        end

        it do
          calculation
          expect(cart.cart_promotions).to be_empty
        end
      end

      context "when there are discounts for the product of the cart_item" do
        before do
          create(:promotion, product_id: product.id, min_quantity: 3, percentage: 10.0)
        end

        context "but the quantity of items is not enough" do
          before do
            create(:cart_item, cart: cart, product_id: product.id, quantity: 2)
          end

          it do
            calculation
            expect(cart.cart_promotions).to be_empty
          end
        end

        context "and the quantity of items is enough to apply the discount" do
          before do
            create(:cart_item, cart: cart, product_id: product.id, quantity: 3)
          end

          it do
            calculation
            expect(cart.cart_promotions.size).to eq(1)
            cart_discount = cart.cart_promotions.first
            expect(cart_discount.promotion.product_id).to eq(product.id)
            expect(cart_discount.value).to eq(30.0)
          end
        end

        context "and the bulk_quantity is more than 1" do
          before do
            Promotion.find_by(product_id: product.id).update(bulk_quantity: 2)
            create(:cart_item, cart: cart, product_id: product.id, quantity: 5)
          end

          it "just applies discounts for every bulk of `bulk_quantity`" do
            calculation
            expect(cart.cart_promotions.size).to eq(1)
            cart_discount = cart.cart_promotions.first
            expect(cart_discount.promotion.product_id).to eq(product.id)
            expect(cart_discount.value).to eq(40.0)
          end
        end

        context "and there is no cart_item for that cart_promotion" do
          before do
            create(:cart_promotion, cart: cart, promotion: Promotion.find_by(product_id: product.id), value: 2)
          end

          it do
            expect { calculation }.to change { cart.reload.cart_promotions.size }.by(-1)
          end
        end
      end
    end
  end
end
