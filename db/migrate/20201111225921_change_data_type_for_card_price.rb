class ChangeDataTypeForCardPrice < ActiveRecord::Migration[6.0]
  def change
    change_column :cards, :price, :float
  end
end
