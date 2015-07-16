class BorrowersController < ApplicationController
  def show
  end

  def index
    @borrowers = current_user.borrowers
  end

  def edit
  end
end
