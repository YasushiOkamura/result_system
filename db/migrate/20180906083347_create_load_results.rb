class CreateLoadResults < ActiveRecord::Migration[5.2]
  def change
    create_table :load_results do |t|

      t.timestamps
    end
  end
end
