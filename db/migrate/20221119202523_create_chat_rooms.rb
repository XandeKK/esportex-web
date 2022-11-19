class CreateChatRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :chat_rooms do |t|
      t.string :name, null: false, limit: 50
      t.string :bio, limit: 500
      t.references :chat_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
