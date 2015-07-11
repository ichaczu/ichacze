class CreateLoans < ActiveRecord::Migration
  def change
    create_table :loans do |t|
      t.references :borrower, index: true, foreign_key: true
      t.references :guarantor, index: true, foreign_key: true
      t.integer :duration
      t.integer :amount
      t.integer :rate_of_interest, default: 8
      t.datetime :end_date

      t.timestamps null: false
    end
  end
end
