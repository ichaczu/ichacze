class ChangePeselDataTypeToString < ActiveRecord::Migration
  def change
    change_column :borrowers, :pesel, :string
    change_column :guarantors, :pesel, :string
  end
end
