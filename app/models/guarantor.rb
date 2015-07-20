class Guarantor < ActiveRecord::Base
  has_many :loans

  validates_presence_of :first_name, :last_name, :address, :pesel, :id_series_number
  validates_uniqueness_of :pesel
  validate :pesel_length_and_type

  def personal_data
    "#{first_name} #{last_name}"
  end

  def total_guaranted_amount
    loans.unpaid.sum(:amount)
  end

  def total_unpaid_amount
    total_guaranted_amount - loans.unpaid.sum(:amount_paid)
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
