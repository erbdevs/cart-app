class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :cart_promotions, dependent: :destroy

  def total
    (items_subtotal - promotions_subtotal).round(2)
  end

private

  def items_subtotal
    cart_items.includes(:product).sum(&:subtotal)
  end

  def promotions_subtotal
    cart_promotions.sum(&:value)
  end
end
