# Summary
This little application allows you to simulate the process of adding products into a cart in an e-commerce.

It has the possibility to add discounts to the products that will affect the final price of the cart.

# Running the app
## Run with docker
1. Build and start the docker containers with `docker compose up`
2. Go into the rails container `docker compose exec rails sh`
3. Setup the DB `rails db:setup`
4. Populate it with some data: `rails db:seed`

## Run locally
1. Install proper `rails` and `ruby` versions (see Gemfile)
2. Install postgres
3. Run `bundle` to install the gems
4. Setup the database `rails db:setup`
5. Create some data with the seeds: `rails db:seed`
6. Start the server `rails s`

Whichever option you choose for running the app, at this point, you should be able to navigate into localhost:3000.
You will see a list of products that can be added to the cart.

# Promotion
The most important feature on this app is the Promotions. Thanks to them, you will be able to set different discounts for products.
The promotion is related with the Product with a `belongs_to` relation and also with the cart with the same relation.

The main fields for the Promotion model are:
- percentage: Indicates the percentage of discount. Setting 10.0 means that the promotion will discount a 10% of the original product price when activated.
- min_quantity: Allows you to set the min quantity of item tha a cart_item must have in order to activate the promotion.
- bulk_quantity: Probably the most difficult concept to understand. This quantity is set to 1 by default. If set to more, it means that every discount will be applied in closed bulks of this amounts.
Lets add some examples. For them, we will asume that we have a Product coffee with a unitary price of 2€.

## Promotion simple
percentage: 10.0%
min_quantity: 3
bulk_quantity: 1

If we buy 2 coffies, the unitary price of the coffee keeps being 2€. Total: 4€
If we buy 3 coffies, the unitary price of the coffee is reduced by 10% to 1.8€. Total: 3.6€

## Promotion with bulk_quantity
percentage: 10.0%
min_quantity: 2
bulk_quantity: 2

If we buy 1 coffies, the unitary price of the coffee keeps being 2€. Total: 2€
If we buy 2 coffies, the unitary price of the coffee is reduced by 10% to 1.8€. Total: 3.6€
If we buy 3 coffies, the unitary price of the coffee is reduced by 10% to 1.8€. However, it is only reduced in bulks of two. Total: 1.8 + 1.8 + 2
If we buy 4 coffies, the unitary price of the coffee is reduced by 10% to 1.8€. Total: 1.8 + 1.8 + 1.8 + 1.8
