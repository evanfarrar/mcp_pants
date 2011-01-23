require 'spec_helper'

describe LogEvent do
  describe "create" do
    it "creates a chat message" do
      ChatMessage.destroy_all
      ChatMessage.last.should be_nil
      LogEvent.create!(:message => "2011-01-23 06:25:16 [WARNING] Can't keep up! Did the system time change, or is the server overloaded?")
      ChatMessage.last.should be_nil
      log = LogEvent.create!(:message => "2011-01-23 06:54:58 [INFO] <evanfarrar> yo")
      last_message = ChatMessage.last

      last_message.should_not be_nil
        
      last_message.player.name.should == "evanfarrar"
      last_message.message.should == "yo"
      last_message.log_event.should == log
    end
  end
end
