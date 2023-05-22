class CreateInstallers < ActiveRecord::Migration[6.1]
  def change
    create_table :installers do |t|
      t.string :name, nil: false
      t.string :siren, nil: false, index:  true

      t.timestamps
    end
  end
end
