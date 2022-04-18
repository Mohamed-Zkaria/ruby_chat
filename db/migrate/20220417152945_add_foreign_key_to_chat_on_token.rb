class AddForeignKeyToChatOnToken < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :chats, :applications, column: :application_token, primary_key: "token"
    add_index :chats, [:application_token, :chat_number], unique: true
  end
end
