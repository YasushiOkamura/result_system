class Raps < ActiveRecord::Migration[5.2]
  def change
    create_table :raps do |t|
      t.integer :ekiden_id
      t.string :point
      t.string :athlete
      t.integer :rap_time
      t.text :memo
      t.boolean :broadcasted, default: false
      t.timestamps
    end
  end
end
