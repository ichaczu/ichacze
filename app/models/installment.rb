class Installment < ActiveRecord::Base
  UNPAID = :unpaid
  PAID = :paid

  belongs_to :loan

  validates_presence_of :payday, :amount, :status, :order
  validates_inclusion_of :order, in: 1..3

  scope :unpaid, -> { where(status: UNPAID) }
  scope :upcoming, -> { where("payday <= ? AND status = 'unpaid'", 3.days.from_now) }

  def formatted_payday
    payday.strftime('%d/%m/%Y')
  end

  def pay
    self.status = "paid"
    self.paid_at = Time.current
    self.save
  end

  def formatted_status
    if status == "unpaid"
      if monit_sent
        "monit wysłany (#{monit_sent.strftime('%d/%m/%Y')})"
      else
        "x"
      end
    else
      "zapłacono #{(amount)}: #{paid_at.strftime('%d/%m/%Y')}"
    end
  end
end
