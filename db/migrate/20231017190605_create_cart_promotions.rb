class CreateCartPromotions < ActiveRecord::Migration[7.0]
  def change
    create_table :cart_promotions do |t|
      t.belongs_to :cart, null: false, foreign_key: true
      t.belongs_to :promotion, null: false, foreign_key: true
      t.float :value, null: false

      t.timestamps
    end
  end
end
