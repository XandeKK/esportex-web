class CreateSports < ActiveRecord::Migration[7.0]
  def change
    create_table :sports do |t|
      t.string :name, null: false, limit: 26, unique: true
      t.text :description, null: false, limit: 500

      t.timestamps
    end
  end
end
