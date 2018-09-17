class CreateShortResults < ActiveRecord::Migration[5.2]
  def change
    create_table :short_results do |t|
      t.string :competition
      t.integer :result, limit: 8
      t.float :wind
      t.string :round
      t.string :group
      t.string :rane
      t.integer :finish
      t.integer :athlete_id
      t.integer :tournament_id
      t.string :grade
      t.date :established_date
      t.string :infomation
      t.string :condition
    end
  end
end
