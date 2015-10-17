class MonitsController < ApplicationController
  def index
    @monits = Monit.where(active: true).sort_by(&:days_to_dept_collection)
  end

  def create
    installment = Loan.find(params[:loan_id]).installments.find_by_order(params[:installment_index].to_i+1)
    installment.monits.create(active: true)
    installment.monit_sent = Time.current
    installment.save
    redirect_to loans_path
  end
end
