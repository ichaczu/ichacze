class Monit < ActiveRecord::Base
  belongs_to :installment

  def borrower_data
    installment.loan.borrower.personal_data
  end

  def unpaid_installment_order
    installment.order.to_s
  end

  def days_to_dept_collection
    days_to_collection = 0
    if last_visit_at
      days_to_collection = ((last_visit_at + 7.days).to_date - Time.current.to_date).to_i
    else
      days_to_collection = ((created_at + 14.days).to_date - Time.current.to_date).to_i
    end
  end

  def days_to_dept_collection_status
    days = days_to_dept_collection
    if days <= 3
      "danger"
    elsif days <= 7
      "warning"
    else
      ""
    end
  end

  def dept_collection_in
    collection_date = ((created_at + 14.days).to_date - Time.current.to_date).to_i
    if last_visit_at
      "wizyta odbyła się: #{last_visit_at.strftime('%d/%m/%Y')}"
    elsif collection_date < 0 && !last_visit_at
      "Minęło ponad 14 dni od wysłania monitu!"
    elsif collection_date == 0
      "Dziś"
    elsif collection_date > 0
      "#{collection_date} #{collection_date == 1 ? 'dzień' : 'dni'}"
    end
  end

  def dept_collection_date
    (created_at + 14.days).strftime('%d/%m/%Y')
  end

  def last_visit_formatted
    if last_visit_at
      last_visit_at.strftime('%d/%m/%Y')
    else
     "-"
    end
  end

  def next_visit_in
    if last_visit_at
      next_visit = ((last_visit_at + 7.days).to_date - Time.current.to_date).to_i
      if next_visit < 0
        "Minęło ponad 7 dni od ostatniej wizyty!"
      elsif next_visit == 0
        "Dziś"
      elsif next_visit > 0
        "#{next_visit} #{next_visit == 1 ? 'dzień' : 'dni'}"
      end
    else
      "-"
    end
  end
end
