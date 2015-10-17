class AddVisitDateToVisit < ActiveRecord::Migration
  def change
    add_column :visits, :date_of_visit, :datetime
  end
end
