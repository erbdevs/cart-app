class CartItemsController < ApplicationController
  def create
    @cart_item = current_cart.cart_items.new(cart_item_params)
    @cart_item.save!
    @cart_items = current_cart.cart_items
  end

  def update
    @cart_item = current_cart.cart_items.find_by(product_id: cart_item_params[:product_id])
    @cart_item.quantity = cart_item_params[:quantity]
    @cart_item.save!
    @cart_items = current_cart.cart_items
    redirect_to cart_path
  end

private

  def cart_item_params
    params.require(:cart_item).permit(:product_id, :quantity)
  end
end
