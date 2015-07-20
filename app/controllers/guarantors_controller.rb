class GuarantorsController < ApplicationController
  def index
    @guarantors = current_user.guarantors
  end

  def show
  end
end
