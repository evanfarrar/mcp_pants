class Player < ActiveRecord::Base
  has_many :chat_messages
end
