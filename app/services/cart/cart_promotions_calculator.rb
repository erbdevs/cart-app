class Cart
  class CartPromotionsCalculator
    def self.run(cart)
      delete_stale_promotions(cart)
      generate_new_promotions(cart)
    end

  private

    def self.delete_stale_promotions(cart)
      cart.cart_promotions.each do |cart_promotion|
        cart_promotion.destroy if stale_cart_promotion?(cart_promotion)
      end
    end

    def self.stale_cart_promotion?(cart_promotion)
      cart_item = CartItem.find_by(cart_id: cart_promotion.cart_id, product_id: cart_promotion.promotion.product_id)
      return true unless cart_item
      return true if cart_item.quantity < cart_promotion.promotion.min_quantity

      false
    end

    def self.generate_new_promotions(cart)
      Promotion.where(product_id: cart.cart_items.pluck(:product_id)).each do |promotion|
        cart_item = cart.cart_items.find_by(product_id: promotion.product_id)
        next if cart_item.quantity < promotion.min_quantity

        cart_promotion = cart.cart_promotions.find_or_initialize_by(promotion_id: promotion.id)
        items_out_of_promotion = cart_item.quantity % promotion.bulk_quantity
        unitary_discount = promotion.product.price * promotion.percentage / 100
        total_discount = unitary_discount * (cart_item.quantity - items_out_of_promotion)

        cart_promotion.update!(value: total_discount)
      end
    end
  end
end
