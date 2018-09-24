class CreateFieldResults < ActiveRecord::Migration[5.2]
  def change
    create_table :field_results do |t|
      t.string :competition
      t.float :result
      t.float :wind
      t.string :round
      t.integer :finish
      t.integer :athlete_id
      t.integer :tournament_id
      t.string :grade
      t.date :established_date
      t.string :information
      t.string :condition
    end
  end
end
