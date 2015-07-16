class Borrower < ActiveRecord::Base
  belongs_to :user
  has_many :loans

  def personal_data
    "#{first_name} #{last_name}"
  end

  def total_borrowed_amount
    loans.unpaid.sum(:amount)
  end

  def total_unpaid_amount
    total_borrowed_amount - loans.unpaid.sum(:amount_paid)
  end
end
