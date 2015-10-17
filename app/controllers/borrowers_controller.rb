class BorrowersController < ApplicationController
  def show
  end

  def index
    @borrowers = Borrower.all
  end

  def edit
  end
end
