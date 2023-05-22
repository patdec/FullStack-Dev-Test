class AddUniqIndexToInstallerSiren < ActiveRecord::Migration[6.1]
  def change
    remove_index :installers, :siren
    add_index :installers, :siren, unique: true
  end
end
