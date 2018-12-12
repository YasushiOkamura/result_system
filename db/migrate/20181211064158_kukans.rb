class Kukans < ActiveRecord::Migration[5.2]
  def change
    create_table :kukans do |t|
      t.integer :ekiden_id
      t.string :athlete
      t.integer :kukan_number
      t.float :distance
      t.text :memo
    end
  end
end
