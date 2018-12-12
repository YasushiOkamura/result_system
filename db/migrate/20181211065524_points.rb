class Points < ActiveRecord::Migration[5.2]
  def change
    create_table :points do |t|
      t.integer :ekiden_id
      t.string :name
    end
  end
end
