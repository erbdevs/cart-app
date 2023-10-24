# Summary
This little application allows you to simulate the process of adding products into a cart in an e-commerce.

It has the possibility to add discounts to the products that will affect the final price of the cart.

# Running the app
1. Install proper `rails` and `ruby` versions (see Gemfile)
2. Install postgres
3. Run `bundle` to install the gems
4. Setup the database `rails db:setup`
5. Create some data with the seeds: `rails db:seed`
6. Start the server `rails s`

At this point, you should see a list of products that can be added to the cart.
