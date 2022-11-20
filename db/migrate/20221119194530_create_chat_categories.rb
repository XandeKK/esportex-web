class CreateChatCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :chat_categories do |t|
      t.string :name, null: false, limit: 32
      t.text :description, null: false, limit: 300

      t.timestamps
    end
  end
end
