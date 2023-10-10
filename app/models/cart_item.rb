class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  def subtotal
    quantity * product.price
  end
end
