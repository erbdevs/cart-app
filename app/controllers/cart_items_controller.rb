class CartItemsController < ApplicationController
  before_action :find_cart_item, only:[:create, :update, :destroy]

  def create
    if @cart_item
      @cart_item.quantity += cart_item_params[:quantity].to_i
    else
      @cart_item = current_cart.cart_items.new(cart_item_params)
    end
    @cart_item.save!
    Cart::CartPromotionsCalculator.run(current_cart)
  end

  def update
    @cart_item.quantity = cart_item_params[:quantity]
    if @cart_item.changed?
      @cart_item.save!
      Cart::CartPromotionsCalculator.run(current_cart)
      redirect_to cart_path
    end
  end

  def destroy
    return unless @cart_item

    @cart_item.destroy!
    Cart::CartPromotionsCalculator.run(current_cart)
    redirect_to cart_path
  end

private

  def cart_item_params
    params.require(:cart_item).permit(:product_id, :quantity)
  end

  def find_cart_item
    @cart_item = current_cart.cart_items.find_by(product_id: cart_item_params[:product_id])
  end
end
