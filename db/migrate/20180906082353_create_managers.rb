class CreateManagers < ActiveRecord::Migration[5.2]
  def change
    create_table :managers do |t|
      t.string :login_id, null: false
      t.string :password_digest, null: false
    end
  end
end
