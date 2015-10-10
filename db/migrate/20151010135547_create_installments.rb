class CreateInstallments < ActiveRecord::Migration
  def change
    create_table :installments do |t|
      t.references :loan, index: true, foreign_key: true
      t.integer :amount
      t.string :status, default: 'unpaid'
      t.datetime :payday

      t.timestamps null: false
    end
  end
end
