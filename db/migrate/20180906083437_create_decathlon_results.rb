class CreateDecathlonResults < ActiveRecord::Migration[5.2]
  def change
    create_table :decathlon_results do |t|
      t.integer :total_score
      t.integer :finish
      t.integer :athlete_id
      t.integer :tournament_id
      t.string :grade
      t.date :established_date
      t.string :infomation
      t.string :condition
      t.integer :sprint_100m_id
      t.integer :score_100m
      t.integer :field_lj_id
      t.integer :score_lj
      t.integer :field_sp_id
      t.integer :score_sp
      t.integer :field_hj_id
      t.integer :score_hj
      t.integer :sprint_400m_id
      t.integer :score_400m
      t.integer :sprint_110mh_id
      t.integer :score_110mh
      t.integer :field_dt_id
      t.integer :score_dt
      t.integer :field_pj_id
      t.integer :score_pj
      t.integer :field_jt_id
      t.integer :score_jt
      t.integer :long_1500m_id
      t.integer :score_1500m
    end
  end
end
