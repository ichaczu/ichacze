class Borrower < ActiveRecord::Base
  has_many :loans

  validates_presence_of :first_name, :last_name, :address, :pesel, :id_series_number
  validate :pesel_length

  scope :with_active_loans, -> { includes(:loans).where(loans: { status: Loan::UNPAID }) }

  def personal_data
    "#{first_name} #{last_name}"
  end

  def total_borrowed_amount
    loans.unpaid.sum(:amount)
  end

  def total_unpaid_amount
    total_borrowed_amount - loans.unpaid.sum(:amount_paid)
  end

  private

  def pesel_length
    if pesel.to_s.length != 11
      errors.add(:pesel, I18n.t('errors.pesel.length'))
    end
  end
end
