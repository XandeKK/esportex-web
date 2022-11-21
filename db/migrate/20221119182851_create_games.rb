class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.string :title, limit: 100, default: ""
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false
      t.string :address, null: false
      t.decimal :latitude
      t.decimal :longitude
      t.string :info, limit: 500
      t.references :user, null: false, foreign_key: true
      t.references :sport, null: false, foreign_key: true

      t.timestamps
    end

    create_table :game_participants do |t|
      t.references :user, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end

    create_table :game_comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :game, null: false, foreign_key: true
      t.text :message

      t.timestamps
    end
  end
end
