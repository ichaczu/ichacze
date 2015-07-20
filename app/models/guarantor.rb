class Guarantor < ActiveRecord::Base
  has_many :loans

  validates_presence_of :first_name, :last_name, :address, :pesel, :id_series_number
  validate :pesel_length

  def personal_data
    "#{first_name} #{last_name}"
  end

  private

  def pesel_length
    if pesel.to_s.length != 11
      errors.add(:pesel, I18n.t('errors.pesel.length'))
    end
  end
end
