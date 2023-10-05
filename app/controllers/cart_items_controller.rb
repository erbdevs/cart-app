class CartItemsController < ApplicationController
  def create
    @cart_item = create_cart_item
    current_cart.save!
    @cart_items = current_cart.cart_items
  end

private

  def cart_item_params
    params.require(:cart_item).permit(:product_id, :quantity)
  end

  def create_cart_item
    cart_item = current_cart.cart_items.find_or_create_by(
      product_id: cart_item_params[:product_id]
    )
    cart_item.quantity += cart_item_params[:quantity].to_i
    cart_item.save!

    cart_item
  end
end
