class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.string :street, nil: false
      t.string :zipcode, nil: false
      t.string :city, nil: false
      t.references :country, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
