class Loan < ActiveRecord::Base
  UNPAID = 'unpaid'
  PAID = 'paid'

  belongs_to :borrower
  belongs_to :guarantor

  validates_presence_of :amount, :rate_of_interest, :duration,
                        :day_of_conclusion, :place_of_conclusion,
                        :guarantor_id, :borrower_id
  validates_inclusion_of :duration, in: 1..3
  validates_inclusion_of :amount, in: 100..1000
  validate :pesel_length
  validate :allowed_amount_to_duration

  scope :unpaid, -> { where(status: UNPAID) }

  def borrower_personal_data
    "#{borrower.first_name} #{borrower.last_name}"
  end

  def formatted_end_date
    end_date.strftime('%d/%m/%Y')
  end

  def formatted_start_date
    created_at.strftime('%d/%m/%Y')
  end

  def formatted_day_of_conclusion
    day_of_conclusion.strftime('%d/%m/%Y')
  end

  private

  def pesel_length
    if pesel.to_s.length != 11
      errors.add(:pesel, I18n.t('errors.pesel.length'))
    end
  end

  def allowed_amount_to_duration
    if amount.present?
      if amount <= 200 && duration > 1
        add_error_duration_too_long
      elsif (amount >= 300 && amount <= 400) && duration > 2
        add_error_duration_too_long
      elsif amount >= 700 && duration == 2
        add_error_duration_invalid
      end
    end
  end

  def add_error_duration_too_long
    errors.add(:duration, I18n.t('errors.duration.too_long'))
  end

  def add_error_duration_invalid
    errors.add(:duration, I18n.t('errors.duration.invalid'))
  end
end
