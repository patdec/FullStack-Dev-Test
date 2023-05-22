class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.string :name, nil: false, index: true
      t.string :email, nil: false
      t.string :phone, nil: false

      t.timestamps
    end
  end
end
