class Product < ApplicationRecord
  validates :code, :name, :price, presence: true

  validates :name, length: { minimum: 3 }
  validates :code,
            length: { minimum: 3 },
            format: { with: /[A-Z]{2}\d{1}/, message: 'Invalid format for code' }
end
