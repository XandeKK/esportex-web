class CreateChatParticipants < ActiveRecord::Migration[7.0]
  def change
    create_table :chat_participants do |t|
      t.references :user, null: false, foreign_key: true
      t.references :chat_room, null: false, foreign_key: true
      t.string :role, null: false, default: "Normal"

      t.timestamps
    end
  end
end
