class Loan < ActiveRecord::Base
  UNPAID = :unpaid
  PAID = :paid

  belongs_to :borrower
  belongs_to :guarantor
  belongs_to :user
  has_many :installments, dependent: :destroy

  validates_presence_of :amount, :rate_of_interest, :duration,
                        :day_of_conclusion, :place_of_conclusion,
                        :guarantor_id, :borrower_id, :user_id, :end_date
  validates_inclusion_of :duration, in: 1..3
  validates_inclusion_of :amount, in: 100..1000
  validate :allowed_amount_to_duration

  scope :unpaid, -> { where(status: UNPAID) }
  after_create :add_installments

  def borrower_personal_data
    borrower.personal_data
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

  def return_amount
    (amount * 1.5).to_i
  end

  def mark_if_paid
    if installments.unpaid.empty?
      self.status = "paid"
      self.save
    end
  end

  def loan_status
    if status == "unpaid" && installments.where("monit_sent IS NOT NULL").present?
      "danger"
    elsif status == "unpaid" && installments.upcoming.present?
      "warning"
    elsif status == "paid"
      "success"
    else
      ""
    end
  end

  def installment_paid?(index)
    if index > installments.count - 1
      true
    else
      installment = installments.find_by_order(index + 1)
      if installment.status == "unpaid"
        false
      else
        true
      end
    end

  end

  def installment_payday(index)
    if index > installments.count - 1
      "-"
    else
      installments.find_by_order(index + 1).formatted_payday
    end
  end

  def installment_status(index)
    if index > installments.count - 1
      "-"
    else
      installments.find_by_order(index + 1).formatted_status
    end
  end

  private

  def add_installments
    installment_amount = amount * 0.5
    (1..duration).each do |i|
      installments.create(amount: installment_amount, payday: Time.current + i.months, order: i)
    end
  end

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
