class CreateAthletes < ActiveRecord::Migration[5.2]
  def change
    create_table :athletes do |t|
      t.string :name
      t.string :grade
      t.string :sex
      t.string :major
      t.text :memo
      t.boolean :active
      t.timestamps
    end
  end
end
