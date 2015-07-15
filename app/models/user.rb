class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :borrowers
  has_many :loans, through: :borrowers
  has_many :guarantors, through: :borrowers
end
