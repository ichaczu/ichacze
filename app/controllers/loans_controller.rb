class LoansController < ApplicationController
  before_action :set_amount_array, only: [:new, :create]

  def index
  end

  def show
  end

  def new
    @loan = Loan.new
    @loan.day_of_conclusion = Time.current
    @borrower = Borrower.new
    @guarantor = Guarantor.new
  end

  def edit
  end

  def pay_installment
    loan = Loan.find_by_id(params[:id])
    installment = loan.installments.find_by_order(installment_order)
    installment.pay
    installment.invalidate_monits
    loan.mark_if_paid
    redirect_to loans_path
  end

  def create
    prepare_loan_borrower_guarantor
    calculate_loan_end_date

    unless borrower_and_guarantor_valid?
      @loan.valid?
      render new_loan_path
      return
    end

    if save_borrower && save_guarantor
      set_associations
      if @loan.save
        redirect_to loans_path
        return
      else
        render new_loan_path
      end
    else
      render new_loan_path
    end
  end

  def destroy
  end

  private

  def save_borrower
    if @borrower.changed? || @borrower.new_record?
      @borrower.save
    else
      true
    end
  end

  def save_guarantor
    if @guarantor.changed? || @guarantor.new_record?
      @guarantor.save
    else
      true
    end
  end

  def prepare_loan_borrower_guarantor
    @loan = Loan.new(loan_params)
    @borrower = find_borrower_by_pesel_or_new
    @guarantor = find_guarantor_by_pesel_or_new
  end

  def calculate_loan_end_date
    if @loan.day_of_conclusion && @loan.duration
      @loan.end_date = @loan.day_of_conclusion + @loan.duration.months
    end
  end

  def set_associations
    @loan.borrower = @borrower
    @loan.guarantor = @guarantor
    @loan.user = current_user
  end

  def set_amount_array
    @amount_array = [100, 200, 300, 400, 500, 600, 700, 800, 900, 1000]
  end

  def find_borrower_by_pesel_or_new
    borrower = Borrower.find_by_pesel(borrower_params[:pesel])
    @borrower_found = true

    unless borrower
      @borrower_found = false
      borrower = Borrower.new(borrower_params)
    end

    borrower
  end

  def find_guarantor_by_pesel_or_new
    guarantor = Guarantor.find_by_pesel(guarantor_params[:pesel])

    unless guarantor
      guarantor = Guarantor.new(guarantor_params)
    end

    guarantor
  end

  def reformatted_day_of_conclusion
    @loan.day_of_conclusion.strftime('%d/%m/%Y')
  end

  def borrower_and_guarantor_valid?
    all_valid = []
    all_valid << @borrower.valid?
    all_valid << @guarantor.valid?
    if all_valid.uniq.length == 1 && all_valid.uniq.first
      true
    else
      false
    end
  end

  def installment_order
    params.fetch(:installment_index).to_i + 1
  end

  def loan_params
    loan_params_hash = params.require(:loan).except(:borrower).except(:guarantor).
      permit(:amount, :duration, :rate_of_interest, :day_of_conclusion, :place_of_conclusion)
    day_of_conclusion = loan_params_hash[:day_of_conclusion].to_time
    loan_params_hash.update(day_of_conclusion: day_of_conclusion)
  end

  def borrower_params
    params.require(:loan).require(:borrower).
      permit(:first_name, :last_name, :address, :pesel, :id_series_number)
  end

  def guarantor_params
    params.require(:loan).require(:guarantor).
      permit(:first_name, :last_name, :address, :pesel, :id_series_number)
  end
end
