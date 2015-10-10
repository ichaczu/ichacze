class AddPaidAtToInstallments < ActiveRecord::Migration
  def change
    add_column :installments, :paid_at, :datetime
  end
end
