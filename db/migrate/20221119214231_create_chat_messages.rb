class CreateChatMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :chat_messages do |t|
      t.references :chat_room, null: false, foreign_key: true
      t.references :chat_participant, null: false, foreign_key: true
      t.text :message, null: false

      t.timestamps
    end
  end
end
