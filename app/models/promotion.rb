class Promotion < ApplicationRecord
  belongs_to :product

  validate :validate_min_quantity_and_bulk_quantity

private

  def validate_min_quantity_and_bulk_quantity
    return if bulk_quantity <= min_quantity

    errors.add("bulk_quantity must be smaller than min_quantity")
  end
end
