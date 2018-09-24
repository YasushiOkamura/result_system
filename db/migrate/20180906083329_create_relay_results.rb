class CreateRelayResults < ActiveRecord::Migration[5.2]
  def change
    create_table :relay_results do |t|
      t.string :competition
      t.integer :result, limit: 8
      t.string :round
      t.string :group
      t.string :rane
      t.integer :finish
      t.integer :first_athlete_id
      t.integer :second_athlete_id
      t.integer :third_athlete_id
      t.integer :fourth_athlete_id
      t.integer :tournament_id
      t.string :first_athlete_grade
      t.string :second_athlete_grade
      t.string :third_athlete_grade
      t.string :fourth_athlete_grade
      t.date :established_date
      t.string :information
      t.string :condition
    end
  end
end
