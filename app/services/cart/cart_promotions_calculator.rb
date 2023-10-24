class Cart
  class CartPromotionsCalculator
    def self.run(cart)
      cart.cart_items.each do |cart_item|
        promotion = Promotion.find_by(product_id: cart_item.product_id)
        next unless promotion

        if cart_item.quantity < promotion.min_quantity
          cart_promotion = cart.cart_promotions.find_by(promotion_id: promotion.id)
          cart_promotion.destroy if cart_promotion
        else
          cart_promotion = cart.cart_promotions.find_or_initialize_by(promotion_id: promotion.id)
          items_out_of_promotion = cart_item.quantity % promotion.bulk_quantity
          unitary_discount = promotion.product.price * promotion.percentage / 100
          cart_promotion.value = unitary_discount * (cart_item.quantity - items_out_of_promotion)
          cart_promotion.save
        end
      end
    end
  end
end
