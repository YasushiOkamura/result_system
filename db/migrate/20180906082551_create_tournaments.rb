class CreateTournaments < ActiveRecord::Migration[5.2]
  def change
    create_table :tournaments do |t|
      t.string :name
      t.string :place
      t.date :start_day
      t.date :end_day
    end
  end
end
