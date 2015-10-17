class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.references :monit, index: true, foreign_key: true
      t.string :report_url

      t.timestamps null: false
    end
  end
end
