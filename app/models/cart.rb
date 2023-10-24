class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :cart_promotions, dependent: :destroy

  def total
    cart_items.includes(:product).sum(&:subtotal).round(2)
  end
end
