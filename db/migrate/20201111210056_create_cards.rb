class CreateCards < ActiveRecord::Migration[6.0]
  def change
    create_table :cards do |t|
      t.decimal :price
      t.integer :quantity
      t.string :brand
      t.references :player, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
