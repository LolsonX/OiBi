class CreateData < ActiveRecord::Migration[5.2]
  def change
    create_table :data do |t|
      t.string :name
      t.string :key
      t.string :encryption
      t.string :attachment

      t.timestamps
    end
  end
end
