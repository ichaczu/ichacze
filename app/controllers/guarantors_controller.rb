class GuarantorsController < ApplicationController
  def index
    @guarantors = Guarantor.all
  end

  def show
  end
end
