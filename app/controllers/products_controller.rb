class ProductsController < ApplicationController
  def index
    @products = Product.all
    @cart_item = CartItem.new
  end
end
