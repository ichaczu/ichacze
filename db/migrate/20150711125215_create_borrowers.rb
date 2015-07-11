class CreateBorrowers < ActiveRecord::Migration
  def change
    create_table :borrowers do |t|
      t.references :user, index: true, foreign_key: true
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.text :address, null: false
      t.integer :pesel, null: false
      t.string :id_series_number, null: false

      t.timestamps null: false
    end
  end
end
