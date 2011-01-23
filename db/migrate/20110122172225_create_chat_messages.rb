class CreateChatMessages < ActiveRecord::Migration
  def self.up
    create_table :chat_messages do |t|
      t.string :message
      t.integer :log_event_id
      t.integer :player_id
      t.timestamps
    end
  end

  def self.down
    drop_table :chat_messages
  end
end
