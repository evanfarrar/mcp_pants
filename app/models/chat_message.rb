class ChatMessage < ActiveRecord::Base
  belongs_to :player
  belongs_to :log_event
end
