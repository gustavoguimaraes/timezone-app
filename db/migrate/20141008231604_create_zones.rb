class CreateZones < ActiveRecord::Migration
  def change
    create_table :zones do |t|
      t.string :name
      t.string :city_name
      t.integer :minutes_offset

      t.timestamps
    end
  end
end
