class AddForeignKeyToMessageOnChatNumber < ActiveRecord::Migration[5.0]
  def change
    add_index :messages, [:chat_number, :message_number], unique: true
  end
end
