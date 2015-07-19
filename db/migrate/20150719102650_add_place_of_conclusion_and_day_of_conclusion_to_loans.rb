class AddPlaceOfConclusionAndDayOfConclusionToLoans < ActiveRecord::Migration
  def change
    add_column :loans, :place_of_conclusion, :string
    add_column :loans, :day_of_conclusion, :datetime
  end
end
