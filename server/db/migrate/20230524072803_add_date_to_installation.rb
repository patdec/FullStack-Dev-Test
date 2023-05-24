class AddDateToInstallation < ActiveRecord::Migration[6.1]
  def change
    add_column :installations, :date, :date, null: false
  end
end
