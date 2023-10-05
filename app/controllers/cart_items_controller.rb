class CartItemsController < ApplicationController
  def create
    @cart_item = current_cart.cart_items.new(cart_items_params)
  end

private

  def cart_items_params
    params.permit(:product_id, :quantity)
  end
end
