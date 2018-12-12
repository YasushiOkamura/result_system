class Ekidens < ActiveRecord::Migration[5.2]
  def change
    create_table :ekidens do |t|
      t.string :name
      t.datetime :start_at
      t.string :place
      t.integer :kukans_count
      t.integer :points_count
      t.timestamps
    end
  end
end
