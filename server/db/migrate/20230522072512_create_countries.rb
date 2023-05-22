class CreateCountries < ActiveRecord::Migration[6.1]
  def change
    create_table :countries do |t|
      t.string :name, nil: false
      t.string :iso, nil: false, index: true

      t.timestamps
    end
  end
end
