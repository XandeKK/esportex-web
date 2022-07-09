class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.references :user, null: false, foreign_key: true
      t.references :sport, null: false, foreign_key: true
      t.datetime :start_date
      t.datetime :end_date
      t.st_point :localization
      t.string :address
      t.text :info

      t.timestamps
    end
  end
end
