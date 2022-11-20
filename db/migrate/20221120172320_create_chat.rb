class CreateChat < ActiveRecord::Migration[7.0]
  def change
    create_table :chat_categories do |t|
      t.string :name, null: false, limit: 32
      t.text :description, null: false, limit: 300

      t.timestamps
    end

    create_table :chat_rooms do |t|
      t.string :name, null: false, limit: 50
      t.string :bio, limit: 500
      t.string :token, limit: 32, null: false, unique: true
      t.references :chat_category, null: false, foreign_key: true

      t.timestamps
    end

    create_table :chat_participants do |t|
      t.references :user, null: false, foreign_key: true
      t.references :chat_room, null: false, foreign_key: true
      t.string :role, null: false, default: "Normal"

      t.timestamps
    end

    create_table :chat_messages do |t|
      t.references :chat_room, null: false, foreign_key: true
      t.references :chat_participant, null: false, foreign_key: true
      t.text :message, null: false

      t.timestamps
    end

    create_table :chat_tracks do |t|
      t.references :chat_room, null: false, foreign_key: true
      t.references :chat_participant, null: false, foreign_key: true
      t.datetime :last_view

      t.timestamps
    end
  end
end
