class LoansController < ApplicationController
  def index
  end

  def show
  end

  def new
    @loan = Loan.new
  end

  def edit
  end

  def create
    @loan = Loan.new(loan_params)
    if @loan.save
      binding.pry
    else
      render new_loan_path
    end
  end

  def destroy
  end

  private

  def loan_params
    params.require(:loan).permit(:amount, :duration, :rate_of_interest)
  end
end
