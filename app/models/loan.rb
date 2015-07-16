class Loan < ActiveRecord::Base
  UNPAID = 'unpaid'
  PAID = 'paid'

  belongs_to :borrower
  belongs_to :guarantor

  validates_presence_of :amount, :rate_of_interest, :duration

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
end
