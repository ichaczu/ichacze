class VisitsController < ApplicationController
  def new
    @visit = Visit.new
    @monit_id = params[:monit_id]
    @visit.date_of_visit = Time.current
  end

  def create
    @visit = Visit.new(visit_params)
    if @visit.save
      monit = Monit.find(visit_params[:monit_id])
      monit.last_visit_at = @visit.date_of_visit
      monit.save
      redirect_to monits_path
    else
      render new_visit_path
    end
  end

  private

  def visit_params
    params.require(:visit).permit(:date_of_visit, :monit_id)
  end
end
