class CreatePromotions < ActiveRecord::Migration[7.0]
  def change
    create_table :promotions do |t|
      t.references :product, null: false, foreign_key: true
      t.string :name, null: false
      t.string :description, null: false
      t.integer :min_quantity, null: false, default: 1
      t.integer :bulk_quantity, null: false, default: 1
      t.float :percentage, null: false

      t.timestamps
    end
  end
end
