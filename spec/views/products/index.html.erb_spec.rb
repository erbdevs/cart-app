require 'rails_helper'

RSpec.describe "products/index", type: :view do
  before(:each) do
    assign(:products, [
      Product.create!(
        code: "MA2",
        name: "Eme 12",
        price: 1.12
      ),
      Product.create!(
        code: "MB3",
        name: "Eme 13",
        price: 1.13
      )
    ])
  end

  it "renders list of products" do
    render
    expect(rendered).to match /Products#index/
    expect(rendered).to match /Eme 12/
    expect(rendered).to match /Code: MA2/
    expect(rendered).to match /Price: 1.12/

    expect(rendered).to match /Eme 13/
    expect(rendered).to match /Code: MB3/
    expect(rendered).to match /Price: 1.13/
  end
end
