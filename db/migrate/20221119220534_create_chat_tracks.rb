class CreateChatTracks < ActiveRecord::Migration[7.0]
  def change
    create_table :chat_tracks do |t|
      t.references :chat_room, null: false, foreign_key: true
      t.references :chat_participant, null: false, foreign_key: true
      t.datetime :last_view

      t.timestamps
    end
  end
end
