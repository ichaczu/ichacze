class AddMonitSentToInstallments < ActiveRecord::Migration
  def change
    add_column :installments, :monit_sent, :datetime
  end
end
