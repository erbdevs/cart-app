class CartsController < ApplicationController
  def show
    @cart_items = current_cart.cart_items
  end

  def destroy
    current_cart.destroy
    session[:cart_id] = nil
    redirect_to products_path
  end
end
