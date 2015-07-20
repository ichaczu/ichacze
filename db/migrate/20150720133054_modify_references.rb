class ModifyReferences < ActiveRecord::Migration
  def change
    remove_reference :guarantors, :borrower, index: true, foreign_key: true
    remove_reference :borrowers, :user, index: true, foreign_key: true
    add_reference :loans, :user, index: true, foreign_key: true
  end
end
