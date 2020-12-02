class RemoveProvinceFromCustomers < ActiveRecord::Migration[6.0]
  def change
    remove_column :customers, :province, :string
  end
end
