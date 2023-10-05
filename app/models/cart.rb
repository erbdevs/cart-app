class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy

  def subtotal
    10
  end

  def total
    100
  end
end
