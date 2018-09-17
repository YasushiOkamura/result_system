class CreateCompetitions < ActiveRecord::Migration[5.2]
  def change
    create_table :competitions do |t|
      t.string :name, unique: true
      t.string :kind
    end
  end
end
