class Borrower < ActiveRecord::Base
  has_many :loans

  validates_presence_of :first_name, :last_name, :address, :pesel, :id_series_number
  validates_uniqueness_of :pesel
  validate :pesel_length_and_type

  scope :with_active_loans, -> { includes(:loans).where(loans: { status: Loan::UNPAID }) }

  def personal_data
    "#{first_name} #{last_name}"
  end

  def total_borrowed_amount
    loans.sum(:amount)
  end

  def total_unpaid_amount
    total_borrowed_amount - loans.includes(:installments).where(installments: { status: "paid" }).sum('installments.amount')
  end

  private

  def pesel_length_and_type
    if pesel.to_s.length != 11
      errors.add(:pesel, I18n.t('errors.pesel.length'))
    elsif pesel.to_i == 0
      errors.add(:pesel, I18n.t('errors.pesel.type'))
    end
  end
end
