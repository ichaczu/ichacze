class AddIdNumberToLoan < ActiveRecord::Migration
  def change
    add_column :loans, :id_number, :string
  end
end
