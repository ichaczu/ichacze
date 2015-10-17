class Installment < ActiveRecord::Base
  UNPAID = :unpaid
  PAID = :paid

  belongs_to :loan
  has_many :monits

  validates_presence_of :payday, :amount, :status, :order
  validates_inclusion_of :order, in: 1..3

  scope :unpaid, -> { where(status: UNPAID) }
  scope :upcoming, -> { where("payday <= ? AND status = 'unpaid'", 3.days.from_now) }
  scope :due, -> { where("payday <= ?", Time.current) }

  def formatted_payday
    payday.strftime('%d/%m/%Y')
  end

  def pay
    self.status = "paid"
    self.paid_at = Time.current
    self.save
  end

  def invalidate_monits
    monits.each do |monit|
      monit.active = false
      monit.save
    end
  end

  def unpaid_due
    if payday < Time.current && status == "unpaid"
      true
    else
      false
    end
  end

  def formatted_status
    if status == "unpaid"
      if monit_sent
        "monit wysłany (#{monit_sent.strftime('%d/%m/%Y')})"
      else
        if payday <= Time.current
          "minął termin wpłaty"
        else
          "x"
        end
      end
    else
      "zapłacono #{(amount)}: #{paid_at.strftime('%d/%m/%Y')}"
    end
  end
end
