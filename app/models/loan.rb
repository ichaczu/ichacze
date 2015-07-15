class Loan < ActiveRecord::Base
  belongs_to :borrower
  belongs_to :guarantor

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
