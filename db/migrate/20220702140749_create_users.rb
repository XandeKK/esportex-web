class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, unique: true, null: false
      t.string :name, null: false, limit: 20
      t.string :username, unique: true, limit: 20, null: false
      t.string :password_digest
      t.text :bio, limit: 300

      t.timestamps
    end
  end
end
