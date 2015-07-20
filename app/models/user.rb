class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :borrowers, through: :loans
  has_many :guarantors, through: :loans
  has_many :loans

  def active_borrowers
    borrowers.with_active_loans
  end
end
