class Guarantor < ActiveRecord::Base
  belongs_to :borrower
  has_many :loans

  def personal_data
    "#{first_name} #{last_name}"
  end
end
