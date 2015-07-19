class Guarantor < ActiveRecord::Base
  has_many :borrower
  has_many :loans

  validates_presence_of :first_name, :last_name, :address, :pesel, :id_series_number, :borrower_id

  def personal_data
    "#{first_name} #{last_name}"
  end
end
