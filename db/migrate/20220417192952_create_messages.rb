class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.integer :chat_number
      t.integer :message_number
      t.text :body
      t.references :chat, null: false, foreign_key: true

      t.timestamps
    end
  end
end
