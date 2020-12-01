class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.references :customer, null: false, foreign_key: true
      t.string :status
      t.float :sub_total
      t.float :gst
      t.float :pst
      t.float :hst
      t.float :total

      t.timestamps
    end
  end
end
