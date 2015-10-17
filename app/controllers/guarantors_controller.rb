class GuarantorsController < ApplicationController
  def index
    @guarantors = Guarantors.all
  end

  def show
  end
end
