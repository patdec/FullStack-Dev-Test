class CreateInstallations < ActiveRecord::Migration[6.1]
  def change
    create_table :installations do |t|
      t.references :customer, null: false, foreign_key: true, index: true
      t.references :installer, null: false, foreign_key: true, index: true
      t.references :address, null: false, foreign_key: true, index: true
      t.integer :panels_number, limit: 2
      t.integer :panels_type, limit: 1
      t.text :panels_ids, array: true, default: []
      t.integer :install_state, limit: 1, default: 0, null: false, index: true

      t.timestamps
    end
  end
end
