class AddUniqIndexToCustomerEmail < ActiveRecord::Migration[6.1]
  def change
    remove_index :customers, :name
    add_index :customers, :email, unique: true
  end
end
