class AddOrderToInstallments < ActiveRecord::Migration
  def change
    add_column :installments, :order, :integer
  end
end
