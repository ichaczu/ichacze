class CreateMonits < ActiveRecord::Migration
  def change
    create_table :monits do |t|
      t.references :installment, index: true, foreign_key: true
      t.boolean :active
      t.datetime :last_visit_at

      t.timestamps null: false
    end
  end
end
