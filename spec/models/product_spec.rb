require 'rails_helper'

RSpec.describe Product do
  let(:product_instance) { build(:product) }

  it 'is valid' do
    expect(product_instance.valid?).to eq(true)
  end

  it 'product is invalid if code is wrong' do
    product_instance.code = "1ABC"

    expect(product_instance.valid?).to eq(false)
  end

  it 'product is invalid if name is wrong' do
    product_instance.name = "wr"

    expect(product_instance.valid?).to eq(false)
  end
end
