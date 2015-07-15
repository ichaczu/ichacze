class Borrower < ActiveRecord::Base
  belongs_to :user
  has_many :loans

  def personal_data
    "#{first_name} #{last_name}"
  end
end
