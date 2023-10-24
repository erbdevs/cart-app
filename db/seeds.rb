# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

[
	{
    code: 'GR1',
    name: 'Green Tea',
    price: 3.11
  },
	{
    code: 'SR1',
    name: 'Strawberries',
    price: 5.00
  },
	{
    code: 'CF1',
    name: 'Cofee',
    price: 11.23
  }
].each do |product_hash|
  Product.find_or_create_by(product_hash)
end

[
  {
    product_id: Product.find_by(code: 'GR1').id,
    name: 'Green tea BOGO',
    description: 'Buy 1 Green Tea Get 1 free',
    min_quantity: 2,
    bulk_quantity: 2,
    percentage: 50.0,
  },
  {
    product_id: Product.find_by(code: 'SR1').id,
    name: 'Strawberries discount',
    description: 'Get 3 strawberries or more and get a 10%',
    min_quantity: 3,
    bulk_quantity: 1,
    percentage: 10.0,
  },
  {
    product_id: Product.find_by(code: 'CF1').id,
    name: 'Coffee discount',
    description: 'Get 3 coffies or more and get a 33%',
    min_quantity: 3,
    bulk_quantity: 1,
    percentage: 33.33,
  }
].each do |discount_hash|
  Promotion.create_or_find_by(discount_hash)
end
