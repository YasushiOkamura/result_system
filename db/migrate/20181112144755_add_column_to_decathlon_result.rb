class AddColumnToDecathlonResult < ActiveRecord::Migration[5.2]
  def change
    add_column :decathlon_results, :official, :boolean
  end
end
