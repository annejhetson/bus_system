class CreateStationsAndLines < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end

    create_table :lines do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end

    create_table :stops do |t|
      t.integer :line_id
      t.integer :station_id
    end
  end
end
