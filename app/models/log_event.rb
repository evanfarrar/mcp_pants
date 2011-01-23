class LogEvent < ActiveRecord::Base
  after_create do
    if message =~ /.*\[INFO\] <([^>]*)> (.*)/
      player = Player.find_or_create_by_name($1)
      ChatMessage.create!(:message => $2, :player => player, :log_event => self)
    end
  end
end
