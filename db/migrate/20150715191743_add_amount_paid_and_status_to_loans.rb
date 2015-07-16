class AddAmountPaidAndStatusToLoans < ActiveRecord::Migration
  def change
    add_column :loans, :amount_paid, :integer
    add_column :loans, :status, :string, default: 'unpaid'
  end
end
