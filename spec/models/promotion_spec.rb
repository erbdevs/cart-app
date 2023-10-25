require 'rails_helper'

RSpec.describe Promotion, type: :model do
  let(:product) { create(:product) }
  let(:promotion_instance) { build(:promotion, product: product) }

  it 'is valid' do
    byebug
    expect(promotion_instance.valid?).to eq(true)
  end

  it 'is invalid if bulk_quantity is greater than min_quantity' do
    promotion_instance.min_quantity = 3
    promotion_instance.bulk_quantity = 4

    expect(promotion_instance.valid?).to eq(false)
  end
end
