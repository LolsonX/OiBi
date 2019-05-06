class CreateEncryptedFiles < ActiveRecord::Migration[5.2]
  def change
    create_table :encrypted_files do |t|
      t.string :name
      t.string :key
      t.string :attachment
      t.string :encryption

      t.timestamps
    end
  end
end
